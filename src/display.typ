#import "utility.typ"
#import "/src/lib/zero/src/zero.typ"

#let _method-prec-table = (add: 1, sub: 1, neg: 2, mul: 2.5, div: 2.5)
#let _method-prec(value) = {
  let op = value.at("source", default: none)
  if op == none { return 1000 }
  _method-prec-table.at(op.op, default: 1000)
}

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
        value.round.at("precision", default: 15),
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
  let _method-wrap(value, min-prec, show-error: false) = {
    let rendered = method(value, show-error: show-error)
    if _method-prec(value) < min-prec { $(#rendered)$ } else { rendered }
  }
  value = utility.normalise-quantity(value)
  if value.at("source", default: none) != none {
    let operation = value.source.op
    if operation == "add" {
      $#value.source.data.map(x => _method-wrap(x, 1, show-error: show-error)).join($+$)$
    } else if operation == "sub" {
      let (a, terms) = value.source.data
      let rest = terms.map(t => $- #_method-wrap(t, 2, show-error: show-error)$).join()
      $#_method-wrap(a, 1, show-error: show-error) #rest$
    } else if operation == "neg" {
      $- #_method-wrap(value.source.data, 2, show-error: show-error)$
    } else if operation == "abs" {
      $abs(#method(value.source.data, show-error: show-error))$
    } else if operation == "mul" {
      context {
        let product = zero.impl.num-state.get().product
        $#value.source.data.map(x => _method-wrap(x, 2.5, show-error: show-error)).join(product)$
      }
    } else if operation == "div" {
      let values = value.source.data.map(x => method(x, show-error: show-error))
      $#values.at(0)/#values.at(1)$
    } else if operation == "pow" {
      let (base, exponent) = value.source.data
      if utility.as-float(base) == calc.e {
        $e^(#method(exponent, show-error: show-error))$
      } else {
        $#_method-wrap(base, 3, show-error: show-error)^(#method(exponent, show-error: show-error))$
      }
    } else if operation == "root" {
      let (radicand, index) = value.source.data
      if utility.as-float(index) == 2 {
        $sqrt(#method(radicand, show-error: show-error))$
      } else {
        $root(#method(index, show-error: show-error), #method(radicand, show-error: show-error))$
      }
    } else if operation == "log" {
      let (val, base) = value.source.data
      if utility.as-float(base) == calc.e {
        $ln(#method(val, show-error: show-error))$
      } else {
        $log_(#method(base, show-error: show-error))(#method(val, show-error: show-error))$
      }
    } else if operation == "sin" {
      $sin(#method(value.source.data, show-error: show-error))$
    } else if operation == "cos" {
      $cos(#method(value.source.data, show-error: show-error))$
    } else if operation == "tan" {
      $tan(#method(value.source.data, show-error: show-error))$
    } else if operation == "asin" {
      $arcsin(#method(value.source.data, show-error: show-error))$
    } else if operation == "acos" {
      $arccos(#method(value.source.data, show-error: show-error))$
    } else if operation == "atan" {
      $arctan(#method(value.source.data, show-error: show-error))$
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
  let errors = errors.filter(x => (
    not x.at("constant", default: false) and utility.as-uncertainty(x) not in (none, 0)
  ))
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

#let _has-error(x) = not x.at("constant", default: false) and utility.as-uncertainty(x) not in (none, 0)

#let error-method(value) = {
  value = utility.normalise-quantity(value)
  if value.at("source", default: none) != none {
    let operation = value.source.op
    if operation == "add" or operation == "sub" {
      let errors = _deduplicate-errors(value.source.data, consider-value: false)
      if errors.len() == 0 { return $0$ }
      rss(errors.map(x => (count: x.count, error: error-method(x.error))))
    } else if operation == "abs" or operation == "neg" {
      error-method(value.source.data)
    } else if operation == "mul" or operation == "div" {
      let errors = _deduplicate-errors(value.source.data)
      if errors.len() == 0 { return $0$ }
      context {
        let product = zero.impl.num-state.get().product
        $#variable(value, show-error: false) product #rss(errors.map(x => (count: x.count, error: $#error-method(x.error)/ #variable(x.error, show-error: false)$)))$
      }
    } else if operation == "pow" {
      let (base, exponent) = value.source.data
      let terms = ()
      if _has-error(base) {
        terms.push((
          count: 1,
          error: context {
            let product = zero.impl.num-state.get().product
            $#variable(exponent, show-error: false) product #variable(value, show-error: false) product #error-method(base)/#variable(base, show-error: false)$
          },
        ))
      }
      if _has-error(exponent) {
        terms.push((
          count: 1,
          error: $#variable(value, show-error: false) dot ln(#variable(base, show-error: false)) dot #error-method(exponent)$,
        ))
      }
      if terms.len() == 0 { return $0$ }
      rss(terms)
    } else if operation == "root" {
      let (radicand, index) = value.source.data
      let terms = ()
      if _has-error(radicand) {
        terms.push((
          count: 1,
          error: context {
            let product = zero.impl.num-state.get().product
            $#variable(index, show-error: false) product #variable(value, show-error: false) product #error-method(radicand)/#variable(radicand, show-error: false)$
          },
        ))
      }
      if _has-error(index) {
        terms.push((
          count: 1,
          error: $#variable(value, show-error: false) dot ln(#variable(radicand, show-error: false)) dot #error-method(index)$,
        ))
      }
      if terms.len() == 0 { return $0$ }
      rss(terms)
    } else if operation == "log" {
      let (val, base) = value.source.data
      let terms = ()
      if _has-error(val) {
        terms.push((
          count: 1,
          error: $#error-method(val) / (#variable(val, show-error: false) dot ln(#variable(base, show-error: false)))$,
        ))
      }
      if _has-error(base) {
        terms.push((
          count: 1,
          error: $#variable(value, show-error: false) dot #error-method(base) / (#variable(base, show-error: false) dot ln(#variable(base, show-error: false)))$,
        ))
      }
      if terms.len() == 0 { return $0$ }
      rss(terms)
    } else if operation == "sin" {
      if not _has-error(value.source.data) { return $0$ }
      $abs(cos(#variable(value.source.data, show-error: false))) dot #error-method(value.source.data)$
    } else if operation == "cos" {
      if not _has-error(value.source.data) { return $0$ }
      $abs(sin(#variable(value.source.data, show-error: false))) dot #error-method(value.source.data)$
    } else if operation == "tan" {
      if not _has-error(value.source.data) { return $0$ }
      $#error-method(value.source.data) / cos^2(#variable(value.source.data, show-error: false))$
    } else if operation == "asin" or operation == "acos" {
      if not _has-error(value.source.data) { return $0$ }
      $#error-method(value.source.data) / sqrt(1 - #variable(value.source.data, show-error: false)^2)$
    } else if operation == "atan" {
      if not _has-error(value.source.data) { return $0$ }
      $#error-method(value.source.data) / (1 + #variable(value.source.data, show-error: false)^2)$
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
    let content-to-str = utility.to-str(slots.index)
    let number-match = content-to-str.match(utility.valid-number-regex)
    if float(number-match.text) == 2 {
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
