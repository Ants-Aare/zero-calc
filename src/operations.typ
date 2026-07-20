// calc-impl.typ
#import "lib/zero/src/zero.typ":*
#import "units.typ":*

#let rss(terms) = {
  terms = terms.filter(x=> x != none) 
  if terms == (){
    return none
  }
  return calc.sqrt(terms.map(t => t * t).sum())
}

#let count-sig-figs(int, frac) = {
  // a = integer-part digits, b = fractional-part digits (may be "")
  let digits = int + frac
  let start = 0
  while start < digits.len() - 1 and digits.at(start) == "0" {
    start += 1
  }
  digits = digits.slice(start)
  if frac == "" {
    while digits.len() > 1 and digits.ends-with("0") {
      digits = digits.slice(0, digits.len() - 1)
    }
  }
  return digits.len()
}

// whichever has the lowest amount of significant figures after the comma wins
#let get-error-sig-figs(datas, max-e) = calc.min(int.max, ..datas.map(x=> {
  if x.info.pm != none{
    let e = int(if x.info.e == none {0}else{x.info.e})
    let pm = impl.utility.shift-decimal-left(x.info.pm.at(0), x.info.pm.at(1), digits:-(e - max-e))
    pm.at(1).len()
  } else{int.max}
}))

#let get-error-sig-figs-mult(datas) = calc.min(int.max, ..datas.map(x => {
  if x.info.pm != none {
    count-sig-figs(x.info.pm.at(0), x.info.pm.at(1))
  } else { int.max }
}))

#let get-sig-figs(datas, max-e) = calc.max(0, ..datas.map(x=> {
    let e = int(if x.info.e == none {0}else{x.info.e})
    let pm = impl.utility.shift-decimal-left(x.info.int, x.info.frac, digits:-(e - max-e))
    for x in range(pm.at(1).len()).rev() {
      let f = pm.at(1).at(x)
      if (f != "0"){
        return (x + 1)
      }
    }
    return 0
  }))

#let get-sig-figs-mult(datas) = calc.min(..datas.map(x => count-sig-figs(x.info.int, x.info.frac)))

#let round-to-sig-figs(value, sig-figs) = {
  if value == 0 {
    return (sign: "+", integer: "0", fractional: "", e: none)
  }
  let sign = if value < 0 { "-" } else { "+" }
  let absval = calc.abs(value)
  let p = calc.floor(calc.log(absval, base: 10))

  if p + 1 <= sig-figs {
    let decimalPlaces = sig-figs - 1 - p
    let (sign, integer, fractional) = impl.parsing.decompose-signed-float-numeral(str(absval))
    (integer, fractional) = impl.utility.shift-decimal-left(integer, fractional, digits: 0)
    fractional = ("000000000" + fractional).slice(0, count: -decimalPlaces + fractional.len() + 9).slice(-1)
    fractional += "000000000"
    fractional = fractional.slice(0, count: decimalPlaces)
    return (sign: sign, integer: integer, fractional: fractional, e: none)
  } else {
    let e-out = p - sig-figs + 1
    let mantissa = calc.floor(absval / calc.pow(10.0, e-out))
    return (sign: sign, integer: str(int(mantissa)), fractional: "", e: str(e-out))
  }
}


#let add(terms, unit) = {
  let max-exponent = calc.max(..terms.map(x => if x.info.e != none { int(x.info.e) } else { 0 }))
  let sig-figs = get-sig-figs(terms, max-exponent)

  let sum = terms.map(x => x.float).sum()
  let (sign, integer, fractional) = impl.parsing.decompose-signed-float-numeral(str(sum))
  (integer, fractional) = impl.utility.shift-decimal-left(integer, fractional, digits:max-exponent)
  fractional = fractional.slice(0,count:sig-figs)
    
  let error = rss(terms.map(x => x.uncertainty))
  let plus-minus = if error != none {
    let error-sig-figs = get-error-sig-figs(terms, max-exponent)
    let (pm-integer, pm-fractional) = impl.parsing.decompose-unsigned-float-numeral(str(error))
    (pm-integer, pm-fractional) = ("000000000" + pm-integer, pm-fractional + "000000000")
    (pm-integer, pm-fractional) = impl.utility.shift-decimal-left(pm-integer, pm-fractional, digits:max-exponent)
    (pm-integer, pm-fractional.slice(0,count:error-sig-figs))
  }

  return (
    sum, 
    error,
    (
      int: integer,
      frac: fractional,
      sign: sign,
      pm: plus-minus,
      e: if max-exponent != 0 {str(max-exponent)},
    ),
    unit,
    (op:"add", data:terms,)
  )
}

#let abs(a, ..args) = {
  let data = normalise-quantities((a,)).at(0)
  data.float = calc.abs(data.float)
  data.info.sign = "+"
  display(data.float, data.uncertainty, data.info, data.at("unit", default:none), source:(op:"abs", data:data), ..args)
}

#let mul(terms) = {
  let unit = multiply-unit(terms.map(x => x.at("unit", default: none)))

  let product = terms.map(x => x.float).fold(1.0, (acc, x) => acc * x)
  let relative-error-terms = terms.map(x => {
    if x.uncertainty != none and x.float != 0 {
      x.uncertainty / x.float
    }
  })
  let error = if relative-error-terms.any(x => x != none) {
    calc.abs(product) * rss(relative-error-terms)
  }

  let (sig-figs, error-sig-figs) = if error != none {
    let error-sig-figs = calc.max(1, get-error-sig-figs-mult(terms))
    let error-places = calc.floor(calc.log(calc.abs(error), base: 10))
    let decimal-place = error-places - error-sig-figs + 1
    let product-places = calc.floor(calc.log(calc.abs(product), base: 10))
    (calc.max(1, product-places - decimal-place + 1), error-sig-figs)
  } else {
    (calc.max(1, get-sig-figs-mult(terms)), none)
  }

  let (sign, integer, fractional, e) = round-to-sig-figs(product, sig-figs)

  let plus-minus
  if error != none {
    let rounded-error = round-to-sig-figs(error, error-sig-figs)
    if rounded-error.e == e {
      // plus-minus = (rounded-error.integer, rounded-error.fractional)
      plus-minus = impl.utility.shift-decimal-left(rounded-error.integer, rounded-error.fractional, digits: if rounded-error.e != none { int(rounded-error.e) } else { 0 } - (if e != none { int(e) } else { 0 }))
    } else {
      plus-minus = impl.utility.shift-decimal-left(rounded-error.integer, rounded-error.fractional, digits: if rounded-error.e != none { int(rounded-error.e) } else { 0 } - (if e != none { int(e) } else { 0 }))
    }
  }

  return (
    product, 
    error,
    (
      int: integer,
      frac: fractional,
      sign: sign,
      pm: plus-minus,
      e: e,
    ),
    unit,
    (op:"mul", data:terms,)
  )
}

#let div(dividend, divisor) = {
  assert(divisor.float != 0, message: "Cannot divide by zero.")
  let unit = multiply-unit((dividend.at("unit", default: none), invert-unit(divisor.at("unit", default: none))))
  let datas = (dividend, divisor)
  let quotient = dividend.float / divisor.float

  let relative-error-terms = datas.map(x => {
    if x.uncertainty != none and x.float != 0 {
      x.uncertainty / x.float
    }
  })
  let error = if relative-error-terms.any(x => x != none) {
    calc.abs(quotient) * rss(relative-error-terms)
  }

  let (sig-figs, error-sig-figs) = if error != none {
    let error-sig-figs = calc.max(1, get-error-sig-figs-mult(datas))
    let error-places = calc.floor(calc.log(calc.abs(error), base: 10))
    let decimal-place = error-places - error-sig-figs + 1
    let quotient-places = calc.floor(calc.log(calc.abs(quotient), base: 10))
    (calc.max(1, quotient-places - decimal-place + 1), error-sig-figs)
  } else {
    (calc.max(1, get-sig-figs-mult((a, b))), none)
  }

  let (sign, integer, fractional, e) = round-to-sig-figs(quotient, sig-figs)

  let plus-minus
  if error != none {
    let rounded-error = round-to-sig-figs(error, error-sig-figs)
    plus-minus = impl.utility.shift-decimal-left(
      rounded-error.integer, rounded-error.fractional,
      digits: (if rounded-error.e != none { int(rounded-error.e) } else { 0 })
            - (if e != none { int(e) } else { 0 }),
    )
  }

  return (
    quotient,
    error,
    (
      int: integer,
      frac: fractional,
      sign: sign,
      pm: plus-minus,
      e: e,
    ),
    unit,
    (op: "div", data: datas),
  )
}

#let pow(base, exp) = {
  assert(exp.at("unit", default:none) == none or exp.unit == (), message: "Exponent must be a plain number, not a quantity.")
  if base.at("unit", default:none) != none {
    assert(exp.uncertainty == none or exp.uncertainty == 0, message: "Cannot raise a unit to an uncertain power.")
    assert(calc.fract(exp.float) == 0, message: "Cannot raise a unit to a non-integer power.")
  }
  if exp.uncertainty != none {
    assert(base.float > 0, message: "Uncertain exponent requires a positive base (derivative undefined otherwise).")
  }

  let unit = pow-unit(base.at("unit", default: none), exp.float)
  let result = calc.pow(base.float, exp.float)

  let error-terms = (
    if base.uncertainty != none and base.float != 0 {
      exp.float * calc.abs(result) * (base.uncertainty / calc.abs(base.float))
    },
    if exp.uncertainty != none {
      calc.abs(result) * calc.abs(calc.ln(base.float)) * exp.uncertainty
    },
  )
  let error = if error-terms.any(x => x != none) { rss(error-terms) }

  let (sig-figs, error-sig-figs) = if error != none {
    let error-sig-figs = calc.max(1, get-error-sig-figs-mult((base, exp)))
    let error-places = calc.floor(calc.log(calc.abs(error), base: 10))
    let decimal-place = error-places - error-sig-figs + 1
    let result-places = calc.floor(calc.log(calc.abs(result), base: 10))
    (calc.max(1, result-places - decimal-place + 1), error-sig-figs)
  } else {
    (calc.max(1, get-sig-figs-mult((base, exp))), none)
  }

  let (sign, integer, fractional, e) = round-to-sig-figs(result, sig-figs)

  let plus-minus
  if error != none {
    let rounded-error = round-to-sig-figs(error, error-sig-figs)
    plus-minus = impl.utility.shift-decimal-left(
      rounded-error.integer, rounded-error.fractional,
      digits: (if rounded-error.e != none { int(rounded-error.e) } else { 0 })
            - (if e != none { int(e) } else { 0 }),
    )
  }

  return (
    result,
    error,
    (
      int: integer,
      frac: fractional,
      sign: sign,
      pm: plus-minus,
      e: e,
    ),
    unit,
    (op: "div", data: (base, exp)),
  )
}