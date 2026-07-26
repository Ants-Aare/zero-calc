// operations.typ
#import "lib/zero/src/zero.typ": *
#import "units.typ": *
#import "utils.typ": as-float, as-uncertainty, get-places

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
  let target-e = calc.max(..terms.map(x => if x.info.e != none { int(x.info.e) } else { 0 }))
  return (
    float: sum,
    uncertainty: error,
    info: create-info(sum, error, target-e),
    round: get-places(terms.map(x => (x.info, x.at("round", default: none))), target-e),
    unit: unit,
    source: (op: "add", data: terms),
  )
}

#let sub(a, terms) = {
  terms
    .slice(1)
    .map(x => {
      if x.at("float", default: none) != none { x.float = -x.float }
      x.info.sign = if x.info.sign == "-" { "+" } else { "-" }
      x
    })

  term.info.sign = if term.info.sign == "-" { "+" } else { "-" }
  return add((datas.first(),) + terms)
}

//negates a term
#let neg(term) = {
  term.info.sign = if term.info.sign == "-" { "+" } else { "-" }
  return (
    float: -as-float(term),
    uncertainty: as-uncertainty(term),
    info: term.info,
    round: term.at("round", default: none),
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

  let product = terms.map(as-float).fold(1.0, (acc, x) => acc * x)
  let relative-error-terms = terms.map(x => {
    let uncertainty = as-uncertainty(x)
    let float = as-float(x)
    if uncertainty != none and float != 0 {
      uncertainty / float
    }
  })
  let error = if relative-error-terms.any(x => x != none) {
    calc.abs(product) * rss(relative-error-terms)
  }
  let e = if product != 0 { calc.floor(calc.log(calc.abs(product), base: 10)) } else { 0 }
  // let sum = terms.map(as-float).sum()
  // let error = rss(terms.map(as-uncertainty))

  let (integer, fractional) = impl.parsing.decompose-unsigned-float-numeral(str(calc.abs(product)))
  // (integer, fractional) = impl.utility.shift-decimal-left(integer, fractional, digits: max-exponent)
  // fractional = fractional.slice(0, count: sig-figs)

  let plus-minus = if error != none {
    let error-sig-figs = get-error-sig-figs(terms, e)
    let (pm-integer, pm-fractional) = impl.parsing.decompose-unsigned-float-numeral(str(error))
    (pm-integer, pm-fractional) = ("000000000" + pm-integer, pm-fractional + "000000000")
    (pm-integer, pm-fractional) = impl.utility.shift-decimal-left(pm-integer, pm-fractional, digits: 2)
    (pm-integer, pm-fractional.slice(0, count: error-sig-figs))
  }

  let (sig-figs, error-sig-figs) = if error != none and error != 0 {
    let error-sig-figs = calc.max(1, get-error-sig-figs-mult(terms))
    let error-places = calc.floor(calc.log(calc.abs(error), base: 10))
    let decimal-place = error-places - error-sig-figs + 1
    let product-places = calc.floor(calc.log(calc.abs(product), base: 10))
    (calc.max(1, product-places - decimal-place + 1), error-sig-figs)
  } else {
    (calc.max(1, get-sig-figs-mult(terms)), none)
  }

  let (sign, integer, fractional, e) = round-to-sig-figs(product, sig-figs)

  return (
    product,
    error,
    (
      int: integer,
      frac: fractional,
      sign: if product >= 0 { "+" } else { "-" },
      pm: plus-minus,
      e: e,
    ),
    unit,
    (op: "mul", data: terms),
  )
}

// #let div(dividend, divisor) = {
//   assert(divisor.float != 0, message: "Cannot divide by zero.")
//   let unit = multiply-unit((dividend.at("unit", default: none), invert-unit(divisor.at("unit", default: none))))
//   let datas = (dividend, divisor)
//   let quotient = dividend.float / divisor.float

//   let relative-error-terms = datas.map(x => {
//     if x.uncertainty != none and x.float != 0 {
//       x.uncertainty / x.float
//     }
//   })
//   let error = if relative-error-terms.any(x => x != none) {
//     calc.abs(quotient) * rss(relative-error-terms)
//   }

//   let (sig-figs, error-sig-figs) = if error != none {
//     let error-sig-figs = calc.max(1, get-error-sig-figs-mult(datas))
//     let error-places = calc.floor(calc.log(calc.abs(error), base: 10))
//     let decimal-place = error-places - error-sig-figs + 1
//     let quotient-places = calc.floor(calc.log(calc.abs(quotient), base: 10))
//     (calc.max(1, quotient-places - decimal-place + 1), error-sig-figs)
//   } else {
//     (calc.max(1, get-sig-figs-mult((a, b))), none)
//   }

//   let (sign, integer, fractional, e) = round-to-sig-figs(quotient, sig-figs)

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
//     quotient,
//     error,
//     (
//       int: integer,
//       frac: fractional,
//       sign: sign,
//       pm: plus-minus,
//       e: e,
//     ),
//     unit,
//     (op: "div", data: datas),
//   )
// }

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
