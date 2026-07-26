// operations.typ
#import "lib/zero/src/zero.typ": *
#import "units.typ": *
#import "utility.typ": as-float, as-uncertainty, get-e, get-places, get-sig-figs

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
      terms.map(x => (x.info, x.args.named().at("round", default: x.at("round", default: none)))),
      target-e,
    ),
    unit: unit,
    source: (op: "add", data: terms),
  )
}

#let sub(a, terms) = {
  let unit = a.at("unit", default: none)
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
    round: x.args.named().at("round", default: x.at("round", default: none)),
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
  let error = if terms.any(x => x.uncertainty != none) {
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
    round: get-sig-figs(terms.map(x => (x.info, x.args.named().at("round", default: x.at("round", default: none))))),
    unit: unit,
    source: (op: "mul", data: terms),
  )
}

#let div(dividend, divisor) = {
  let unit = multiply-unit((dividend.at("unit", default: none), invert-unit(divisor.at("unit", default: none))))
  let terms = (dividend, divisor)
  let quotient = dividend.float / divisor.float

  let error = if terms.any(x => x.uncertainty != none) {
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
  let target-e = get-value-e(quotient)
  return (
    float: quotient,
    uncertainty: error,
    info: create-info(quotient, error, target-e),
    round: get-sig-figs(terms.map(x => (x.info, x.args.named().at("round", default: x.at("round", default: none))))),
    unit: unit,
    source: (op: "div", data: terms),
  )
}

// #let pow(base, exponent) = {
//   assert(
//     exponent.at("unit", default: none) == none or exp.unit == (),
//     message: "Exponent must be a plain number, not a quantity.",
//   )
//   if base.at("unit", default: none) != none {
//     assert(exponent.uncertainty == none or exponent.uncertainty == 0, message: "Cannot raise a unit to an uncertain power.")
//     assert(calc.fract(exponent.float) == 0, message: "Cannot raise a unit to a non-integer power.")
//   }
//   if exponent.uncertainty != none {
//     assert(base.float > 0, message: "Uncertain exponent requires a positive base (derivative undefined otherwise).")
//   }

//   let unit = pow-unit(base.at("unit", default: none), exponent.float)
//   let result = calc.pow(base.float, exponent.float)

//   let error-terms = (
//     if base.uncertainty != none and base.float != 0 {
//       exponent.float * calc.abs(result) * (base.uncertainty / calc.abs(base.float))
//     },
//     if exp.uncertainty != none {
//       calc.abs(result) * calc.abs(calc.ln(base.float)) * exponent.uncertainty
//     },
//   )
//   let error = if error-terms.any(x => x != none) { rss(error-terms) }

//   let (sig-figs, error-sig-figs) = if error != none {
//     let error-sig-figs = calc.max(1, get-error-sig-figs-mult((base, exponent)))
//     let error-places = calc.floor(calc.log(calc.abs(error), base: 10))
//     let decimal-place = error-places - error-sig-figs + 1
//     let result-places = calc.floor(calc.log(calc.abs(result), base: 10))
//     (calc.max(1, result-places - decimal-place + 1), error-sig-figs)
//   } else {
//     (calc.max(1, get-sig-figs-mult((base, exponent))), none)
//   }

//   let (sign, integer, fractional, e) = round-to-sig-figs(result, sig-figs)

//   let plus-minus
//   if error != none {
//     let rounded-error = round-to-sig-figs(error, error-sig-figs)
//     plus-minus = impl.utility.shift-decimal-left(
//       rounded-error.integer,
//       rounded-error.fractional,
//       digits: (if rounded-error.e != none { int(rounded-error.e) } else { 0 }) - (if e != none { int(e) } else { 0 }),
//     )
//   }

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
//     (op: "div", data: (base, exp)),
//   )
// }
// #let exp(exponent) = pow((float:calc.e, info:(...)), exponent)

// #let root(radicand, index) = {
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
//     (op: "root", data: (base, exp)),
//   )
// }

// #let sqrt(radicand) = root(radicand, (float:2, ...))

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
