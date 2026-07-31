#import "utility.typ"
#import "/src/lib/zero/src/zero.typ"

#let variable(value, show-error: true) = {
  value = utility.normalise-quantity(value)

  if show-error == false {
    let args = value.at("args", default: none)
    let round = value.at("round", default: none)
    if round == none and args != none {
      value.round = args.named().at("round", default: none)
      round = value.round
    }
    if round != none {
      value.round.precision = calc.min(
        value.round.at("uncertainty-precision", default: 15),
        value.at("pm", default: (none, range(15))).at(1).len(),
      )
      let x = value.round.remove("uncertainty-precision", default: none)
    }
    if args != none {
      let named = args.named()
      let x = named.remove("round", default: none)
      value.args = arguments(args.pos(), named)
    }
    value.info.pm = none
  }
  let x = value.remove("source", default: none)
  utility.display(value)
}


#let method(value, show-error: false) = {
  value = utility.normalise-quantity(value)
  if value.at("source", default: none) != none {
    let operation = value.source.op
    if operation == "add" {
      $#value.source.data.map(x => method(x, show-error: show-error)).join($+$)$
    } else if operation == "mul" {
      context {
        let product = zero.impl.num-state.get().product
        $#value.source.data.map(x => method(x, show-error: show-error)).join(product)$
      }
    } else if operation == "div" {
      let values = value.source.data.map(x => method(x, show-error: show-error))
      $#values.at(0)/#values.at(1)$
    }
  } else {
    variable(value, show-error: show-error)
  }
}

#let method-result(value, show-error: false, ..args) = {
  value = utility.normalise-quantity(value)

  math.equation(
    $
      #method(value, show-error: show-error) = #variable(value, show-error: show-error)
    $,
    ..args,
  )
}

#let error(value) = {
  value = utility.normalise-quantity(value)
  let info = if value.info.pm == none or value.info.pm == () {
    (
      int: "0",
      frac: "",
      sign: "+",
      pm: none,
      e: none,
    )
  } else {
    (
      int: value.info.pm.at(0),
      frac: value.info.pm.at(1),
      sign: "+",
      pm: none,
      e: value.info.e,
    )
  }
  let round = value.at("round", default: none)
  if round == none and value.at("args", default: none) != none {
    round = value.args.named().at("round", default: none)
  }
  round = if (
    round != none and round.at("uncertainty-precision", default: none) != none
  ) {
    (
      precision: round.uncertainty-precision,
      mode: round.mode,
    )
  }
  utility.display((info: info, unit: value.at("unit", default: none), round: round))
}

#let rss(errors) = {
  context {
    let product = zero.impl.num-state.get().product
    $sqrt(#errors.map(t => $#if t.count != 1 { $#t.count product$ } (#t.error)^2$).join($+$))$
  }
}

#let _deduplicate-errors(errors, consider-value: true) = {
  let errors = errors.filter(x => utility.as-uncertainty(x) != 0)
  let dedup-errors = errors.dedup(key: x => if consider-value {
    (utility.as-uncertainty(x), utility.as-float(x))
  } else { utility.as-uncertainty(x) })
  dedup-errors = if dedup-errors.len() != errors.len() {
    dedup-errors.map(x => (
      count: errors.filter(y => utility.as-uncertainty(y) == utility.as-uncertainty(x)).len(),
      error: x,
    ))
  } else {
    dedup-errors.map(x => (count: 1, error: x))
  }
  dedup-errors
}

#let error-method(value) = {
  value = utility.normalise-quantity(value)
  if value.at("source", default: none) != none {
    let operation = value.source.op
    if operation == "add" or operation == "sub" {
      let errors = _deduplicate-errors(value.source.data, consider-value: false)
      rss(errors.map(x => (count: x.count, error: error-method(x.error))))
    } else if operation == "abs" or operation == "neg" {
      error-method(value.source.data)
    } else if operation == "mul" or operation == "div" {
      let errors = _deduplicate-errors(value.source.data)
      context {
        let product = zero.impl.num-state.get().product

        $#variable(value, show-error: false) product #rss(errors.map(x => (count: x.count, error: $#error-method(x.error)/ #variable(x.error, show-error: false)$)))$
      }
    }
  } else {
    error(value)
  }
}

#let error-method-result(value, ..args) = {
  value = utility.normalise-quantity(value)

  math.equation(
    $
      #error-method(value) = #error(value)
    $,
    ..args,
  )
}

// Lower = binds more loosely = more likely to need parens when nested
// inside something tighter. Anything not in this table (frac, root, sqrt,
// abs, pow, and all function calls) is self-delimiting — it visually
// encloses its own children (fraction bar, radical sign, brackets,
// superscript position), so it never needs parens from outside, and
// never forces parens onto what's inside it either.
#let prec-table = (add: 1, sub: 1, neg: 2, pos: 2, mul: 2.5, dot: 2.5, times: 2.5)
#let prec(node) = if type(node) == dictionary { prec-table.at(node.head, default: 1000) } else { 1000 }



// term-sign extraction: turns `neg(x)` into a "-" sign on x, and flags
// add/sub subtrees that need explicit parens when subtracted (since
// "a - (b + c)" != "a - b + c" once flattened into a token stream).
#let signed-add-term(term) = {
  if type(term) == dictionary and term.head == "neg" {
    (sign: "-", node: term.args.at(0), force-parens: false)
  } else {
    (sign: "+", node: term, force-parens: false)
  }
}
#let signed-sub-term(term) = {
  if type(term) == dictionary and term.head == "neg" {
    (sign: "+", node: term.args.at(0), force-parens: false)
  } else if type(term) == dictionary and term.head in ("add", "sub") {
    (sign: "-", node: term, force-parens: true)
  } else {
    (sign: "-", node: term, force-parens: false)
  }
}

#let join-signed(first, rest) = {
  let piece(t) = if t.force-parens { $(#display-equation(t.node))$ } else { wrap(t.node, 1) }
  let out = if first.sign == "-" { $- #piece(first)$ } else { piece(first) }
  for t in rest {
    out = if t.sign == "-" { $#out - #piece(t)$ } else { $#out + #piece(t)$ }
  }
  out
}

#let fn-names = (asin: "arcsin", acos: "arccos", atan: "arctan")
#let fn-call(head, value) = {
  let arg = wrap(value, 0) // always parenthesize function args — simplest, unambiguous
  if head in fn-names { $#math.op(fn-names.at(head))(arg)$ } else { $#math.op(head)(arg)$ }
}

#let display-equation(tree) = {
  let wrap(node, min-prec) = {
    let rendered = display-equation(node)
    if prec(node) < min-prec { $(#rendered)$ } else { rendered }
  }
  if type(tree) == array { return tree.map(display-equation) }
  if type(tree) != dictionary { return tree }

  let head = tree.head
  let args = tree.at("args", default: ())
  let slots = tree.at("slots", default: (:))

  if head == "eq" {
    return $#display-equation(args.at(0)) = #display-equation(args.at(1))$
  }

  if head == "add" {
    let terms = args.map(signed-add-term)
    return join-signed(terms.first(), terms.slice(1))
  }
  if head == "sub" {
    // args: (a, t1, t2, ...) meaning a - t1 - t2 - ...
    let a = wrap(args.at(0), 1)
    let terms = args.slice(1).map(signed-sub-term)
    let out = a
    for t in terms {
      let piece = if t.force-parens { $(#display-equation(t.node))$ } else { wrap(t.node, 1) }
      out = if t.sign == "-" { $#out - #piece$ } else { $#out + #piece$ }
    }
    return out
  }
  if head == "pos" {
    return wrap(args.at(0), 2)
  }
  if head == "neg" {
    let inner = args.at(0)
    // double negative cancels
    if type(inner) == dictionary and inner.head == "neg" {
      return display-equation(inner.args.at(0))
    }
    return $- #wrap(inner, 2)$
  }

  if head in ("mul", "dot", "times") {
    let sym = if head == "dot" { $dot$ } else { $times$ }
    let pieces = args.map(f => wrap(f, 2.5))
    let out = pieces.first()
    for p in pieces.slice(1) { out = $#out #sym #p$ }
    return out
  }

  if head == "frac" {
    return $frac(#display-equation(slots.num), #display-equation(slots.denom))$
  }

  if head == "pow" {
    let base = wrap(args.at(0), 4) // add/sub/neg/mul all need parens as a base
    let exp = display-equation(args.at(1)) // superscript position groups it — no visible parens needed
    return $#base^(#exp)$
  }

  if head == "root" {
    let radicand = display-equation(slots.radicand)
    if as-literal-int(slots.index) == 2 {
      return $sqrt(#radicand)$
    }
    return $root(#display-equation(slots.index), #radicand)$
  }
  if head == "sqrt" {
    return $sqrt(#display-equation(slots.radicand))$
  }
  if head in ("abs", "abs-bars") {
    return $abs(#display-equation(slots.value))$
  }

  if head in ("log10", "log", "log-br", "log10-br") {
    let value = display-equation(args.at(0))
    let base = slots.at("base", default: none)
    if base == none or as-literal-int(base) == 10 {
      return $log(#value)$
    }
    if utility.to-str(base) == "e" {
      return $ln(#value)$
    }
    return $log_(#display-equation(base))(#value)$
  }
  if head == "ln" {
    return $ln(#display-equation(args.at(0)))$
  }
  if head == "exp" {
    // exp(x) came from inverting pow(e, x) — display it that way, e^x is clearer than exp(x)
    return $e^(#display-equation(args.at(0)))$
  }

  if head in ("sin", "cos", "tan", "asin", "acos", "atan") {
    return fn-call(head, args.at(0))
  }

  if head == "group" {
    return display-equation(slots.expr)
  }

  panic("display-equation: no rendering defined for operation '" + head + "'")
}
