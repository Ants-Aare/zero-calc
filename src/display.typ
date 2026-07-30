#import "utility.typ"
#import "display-operations.typ" as op
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
