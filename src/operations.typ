// operations.typ
#import "lib/zero/src/zero.typ": *
#import "units.typ": *
#import "utility.typ": (
  as-float, as-round, as-uncertainty, get-e, get-places, get-sig-figs, normalise-constant, normalise-quantity,
)

#let pi = normalise-constant(calc.pi)
#let e = normalise-constant(calc.e)
#let tau = normalise-constant(calc.tau)
#let inf = normalise-constant(calc.inf)

#let rss(terms) = {
  terms = terms.filter(x => x != none)
  if terms != () { calc.sqrt(terms.map(t => t * t).sum()) }
}

#let create-info(value, uncertainty, e) = {
  let (integer, fractional) = impl.utility.shift-decimal-left(
    ..impl.parsing.decompose-unsigned-float-numeral(str(calc.abs(value))),
    digits: e,
  )
  return (
    int: integer,
    frac: fractional,
    sign: if value >= 0 { "+" } else { "-" },
    pm: if uncertainty != none {
      impl.utility.shift-decimal-left(
        ..impl.parsing.decompose-unsigned-float-numeral(str(calc.abs(uncertainty))),
        digits: e,
      )
    },
    e: if e != 0 { str(e).replace("−", "-") },
  )
}

#let add(terms) = {
  let unit = terms.first().at("unit", default: none)
  assert(terms.all(x => x.at("unit", default: none) == unit), message: "All parameters must have the same unit.")
  let sum = terms.map(as-float).sum()
  let error = rss(terms.map(as-uncertainty))
  let target-e = get-e(terms, sum, "highest")
  return (
    float: sum,
    uncertainty: error,
    info: create-info(sum, error, target-e),
    round: get-places(
      terms.filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x))),
      target-e,
    ),
    unit: unit,
    source: (op: "add", data: terms),
  )
}

#let sub(a, terms) = {
  let unit = a.at("unit", default: none)
  if type(terms) != array { terms = (terms,) }
  assert(terms.all(x => x.at("unit", default: none) == unit), message: "All parameters must have the same unit.")
  let negative-terms = terms.map(x => {
    if x.at("float", default: none) != none { x.float = -x.float }
    x.info.sign = if x.info.sign == "-" { "+" } else { "-" }
    x
  })
  let result = add((a,) + negative-terms)
  result.source = (op: "sub", data: (a, terms))
  return result
}

//negates a term
#let neg(term) = {
  term.info.sign = if term.info.sign == "-" { "+" } else { "-" }
  return (
    float: -as-float(term),
    uncertainty: as-uncertainty(term),
    info: term.info,
    round: as-round(term),
    unit: term.unit,
    source: (op: "neg", data: term),
  )
}

#let abs(a, ..args) = {
  let data = normalise-quantities((a,)).at(0)
  data.float = calc.abs(data.float)
  data.info.sign = "+"
  display(
    data.float,
    data.uncertainty,
    data.info,
    data.at("unit", default: none),
    source: (op: "abs", data: data),
    ..args,
  )
}

#let mul(terms) = {
  let unit = multiply-unit(terms.map(x => x.at("unit", default: none)))
  let product = terms.map(as-float).product(default: 0)
  let error = if terms.any(x => as-uncertainty(x) != none) {
    (
      calc.abs(product)
        * rss(terms.map(x => {
          let uncertainty = as-uncertainty(x)
          if uncertainty != none {
            uncertainty / as-float(x)
          }
        }))
    )
  }
  let target-e = get-e(terms, product, "value")
  return (
    float: product,
    uncertainty: error,
    info: create-info(product, error, target-e),
    round: get-sig-figs(terms.filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x)))),
    unit: unit,
    source: (op: "mul", data: terms),
  )
}

#let div(dividend, divisor) = {
  let unit = multiply-unit((dividend.at("unit", default: none), invert-unit(divisor.at("unit", default: none))))
  let terms = (dividend, divisor)
  let quotient = as-float(dividend) / as-float(divisor)

  let error = if terms.any(x => as-uncertainty(x) != none) {
    (
      calc.abs(quotient)
        * rss(terms.map(x => {
          let uncertainty = as-uncertainty(x)
          if uncertainty != none {
            uncertainty / as-float(x)
          }
        }))
    )
  }
  let target-e = get-e(terms, quotient, "value")
  return (
    float: quotient,
    uncertainty: error,
    info: create-info(quotient, error, target-e),
    round: get-sig-figs(terms.filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x)))),
    unit: unit,
    source: (op: "div", data: terms),
  )
}

#let pow(base, exponent) = {
  let exponent-float = as-float(exponent)
  let exponent-uncertainty = as-uncertainty(exponent)
  let base-float = as-float(base)
  let base-uncertainty = as-uncertainty(base)
  let unit = pow-unit(base.at("unit", default: none), exponent-float)
  let result = calc.pow(as-float(base), exponent-float)

  let error-terms = (
    if base-uncertainty != none and base.float != 0 {
      exponent-float * calc.abs(result) * (base-uncertainty / calc.abs(base-float))
    },
    if exponent-uncertainty != none {
      calc.abs(result) * calc.abs(calc.ln(base-float)) * exponent-uncertainty
    },
  )
  let error = if error-terms.any(x => x != none) { rss(error-terms) }

  let target-e = get-e(none, result, "value")
  return (
    float: result,
    uncertainty: error,
    info: create-info(result, error, target-e),
    round: get-sig-figs(
      (base, exponent).filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x))),
    ),
    unit: unit,
    source: (op: "pow", data: (base, exponent)),
  )
}

#let exp(exponent) = pow(e, exponent)

#let root(radicand, index) = {
  let index-float = as-float(index)
  let index-uncertainty = as-uncertainty(index)
  let radicand-float = as-float(radicand)
  let radicand-uncertainty = as-uncertainty(radicand)
  let unit = root-unit(radicand.at("unit", default: none), index-float)
  let result = calc.root(radicand-float, index-float)

  let error-terms = (
    if radicand-uncertainty != none and radicand-float != 0 {
      index-float * calc.abs(result) * (radicand-uncertainty / calc.abs(radicand-float))
    },
    if index-uncertainty != none {
      calc.abs(result) * calc.abs(calc.ln(radicand-float)) * index-uncertainty
    },
  )
  let error = if error-terms.any(x => x != none) { rss(error-terms) }

  let target-e = get-e(none, result, "value")
  return (
    float: result,
    uncertainty: error,
    info: create-info(result, error, target-e),
    round: get-sig-figs((radicand).filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x)))),
    unit: unit,
    source: (op: "pow", data: (radicand, index)),
  )
}

#let sqrt(radicand) = root(radicand, normalise-constant(2))

// #let log(value, base) = {
//   let result = calc.root(as-float(radicand), as-float(index))
//   let error =

//   return (
//     result,
//     error,
//     (
//       int: integer,
//       frac: fractional,
//       sign: sign,
//       pm: plus-minus,
//       e: e,
//     ),
//     unit,
//     (op: "log", data: (base, exp)),
//   )
// }

// #let ln(value) = log(value, (float:calc.e, info:(...)))

// #let sin(angle) = {
//   result = calc.sin(as-float(angle))
//   return (
//     result,
//     error,
//     (
//       int: integer,
//       frac: fractional,
//       sign: sign,
//       pm: plus-minus,
//       e: e,
//     ),
//     unit,
//     (op: "sin", data: (angle,)),
//   )
// }
// #let cos(angle) = {
//   result = calc.cos(as-float(angle))
//   return (
//     result,
//     error,
//     (
//       int: integer,
//       frac: fractional,
//       sign: sign,
//       pm: plus-minus,
//       e: e,
//     ),
//     unit,
//     (op: "cos", data: (angle,)),
//   )
// }

// #let tan(angle) = {
//   result = calc.tan(as-float(angle))
//   return (
//     result,
//     error,
//     (
//       int: integer,
//       frac: fractional,
//       sign: sign,
//       pm: plus-minus,
//       e: e,
//     ),
//     unit,
//     (op: "tan", data: (angle,)),
//   )
// }
