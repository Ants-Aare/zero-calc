#import "@preview/zero:0.7.1"
#import "units.typ"
#import "utility.typ": (
  as-float, as-round, as-uncertainty, create-info, get-e, get-places, get-sig-figs, normalise-constant,
  normalise-quantity, prefixes, rss,
)

#let const = normalise-constant
#let pi = normalise-constant(calc.pi)
#let e = normalise-constant(calc.e)
#let tau = normalise-constant(calc.tau)
#let inf = normalise-constant(calc.inf)

#let add(terms) = {
  let unit = terms.first().at("unit", default: none)
  assert(
    terms.all(x => units.equal(x.at("unit", default: none), unit)),
    message: "All parameters must have the same unit.",
  )
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
    constant: terms.all(x => x.at("constant", default: false)),
    source: (head: "add", data: terms),
    args: terms.map(x => x.at("args", default: none)).sum(),
  )
}

#let sub(a, terms) = {
  let unit = a.at("unit", default: none)
  if type(terms) != array { terms = (terms,) }
  assert(
    terms.all(x => units.equal(x.at("unit", default: none), unit)),
    message: "All parameters must have the same unit.",
  )
  let negative-terms = terms.map(x => {
    if x.at("float", default: none) != none { x.float = -x.float }
    x.info.sign = if x.info.sign == "-" { "+" } else { "-" }
    x
  })
  let result = add((a,) + negative-terms)
  result.source = (head: "sub", data: (a, terms))
  return result
}

#let neg(term) = {
  let original = term
  let value = as-float(term)
  let info = term.info
  if value != 0 { info.sign = if info.sign == "-" { "+" } else { "-" } }
  return (
    float: if value == 0 { value } else { -value },
    uncertainty: as-uncertainty(term),
    info: info,
    round: as-round(term),
    unit: term.at("unit", default: none),
    constant: term.at("constant", default: false),
    source: (head: "neg", data: original),
    args: term.at("args", default: none),
  )
}

#let abs(term) = {
  let original = term
  let value = as-float(term)
  let info = term.info
  info.sign = "+"
  return (
    float: calc.abs(value),
    uncertainty: as-uncertainty(term),
    info: info,
    round: as-round(term),
    unit: term.at("unit", default: none),
    constant: term.at("constant", default: false),
    source: (head: "abs", data: original),
    args: term.at("args", default: none),
  )
}

#let mul(terms) = {
  let unit = units.multiply-unit(terms.map(x => x.at("unit", default: none)))
  let product = terms.map(as-float).product(default: 0)
  let error = if terms.any(x => as-uncertainty(x) != none) {
    rss(terms.enumerate().map(((i, x)) => {
      let uncertainty = as-uncertainty(x)
      if uncertainty != none {
        uncertainty * calc.abs(terms.enumerate().filter(((j, _)) => j != i).map(((_, y)) => as-float(y)).product(default: 1))
      }
    }))
  }
  let target-e = get-e(terms, product, "value")
  return (
    float: product,
    uncertainty: error,
    info: create-info(product, error, target-e),
    round: get-sig-figs(terms.filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x)))),
    unit: unit,
    constant: terms.all(x => x.at("constant", default: false)),
    source: (head: "mul", data: terms),
    args: terms.map(x => x.at("args", default: none)).sum(),
  )
}

#let div(dividend, divisor) = {
  let unit = units.multiply-unit((
    dividend.at("unit", default: none),
    units.invert-unit(divisor.at("unit", default: none)),
  ))
  let terms = (dividend, divisor)
  let quotient = as-float(dividend) / as-float(divisor)

  let error = if terms.any(x => as-uncertainty(x) != none) {
    let (a, b) = (as-float(dividend), as-float(divisor))
    let (ua, ub) = (as-uncertainty(dividend), as-uncertainty(divisor))
    rss((
      if ua != none { ua / calc.abs(b) },
      if ub != none { ub * calc.abs(a) / (b * b) },
    ))
  }
  let target-e = get-e(terms, quotient, "value")
  return (
    float: quotient,
    uncertainty: error,
    info: create-info(quotient, error, target-e),
    round: get-sig-figs(terms.filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x)))),
    unit: unit,
    constant: terms.all(x => x.at("constant", default: false)),
    source: (head: "div", data: terms),
    args: terms.map(x => x.at("args", default: none)).sum(),
  )
}

#let pow(base, exponent) = {
  let exponent-uncertainty = as-uncertainty(exponent)
  assert(
    units.is-unitless(exponent),
    message: "pow: exponent must not carry a unit: " + repr(exponent.at("unit", default: none)),
  )
  assert(
    units.is-unitless(base) or exponent-uncertainty == none,
    message: "pow: exponent must be exact (no uncertainty) when base carries a unit.",
  )

  let exponent-float = as-float(exponent)
  let base-float = as-float(base)
  let base-uncertainty = as-uncertainty(base)

  let unit = units.pow-unit(base.at("unit", default: none), exponent-float)
  let result = calc.pow(base-float, exponent-float)

  let error-terms = (
    if base-uncertainty != none {
      if base-float != 0 {
        exponent-float * calc.abs(result) * (base-uncertainty / calc.abs(base-float))
      } else if exponent-float == 1 {
        base-uncertainty
      } else if exponent-float > 1 {
        0.0
      }
    },
    if exponent-uncertainty != none {
      calc.abs(result) * calc.abs(calc.ln(base-float)) * exponent-uncertainty
    },
  )
  let error = if error-terms.any(x => x != none) { rss(error-terms) }

  if exponent.info.frac.len() == 0 and exponent.info.pm == none {
    exponent.constant = true
  }
  let target-e = get-e(none, result, "value")
  return (
    float: result,
    uncertainty: error,
    info: create-info(result, error, target-e),
    round: get-sig-figs(
      (base, exponent).filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x))),
    ),
    unit: unit,
    constant: (base, exponent).all(x => x.at("constant", default: false)),
    source: (head: "pow", data: (base, exponent)),
    args: (base, exponent).map(x => x.at("args", default: none)).sum(),
  )
}

#let exp(exponent) = pow(e, exponent)

#let root(radicand, index) = {
  let index-float = as-float(index)
  let index-uncertainty = as-uncertainty(index)
  let radicand-float = as-float(radicand)
  let radicand-uncertainty = as-uncertainty(radicand)
  assert(int(index-float) == index-float, message: "only integer index is allowed. index: " + str(index-float))
  assert(
    radicand.at("unit", default: none) == none or index-uncertainty == none,
    message: "root: index must be exact (no uncertainty) when radicand carries a unit.",
  )

  let unit = units.root-unit(radicand.at("unit", default: none), index-float)
  let result = calc.root(radicand-float, int(index-float))

  let error-terms = (
    if radicand-uncertainty != none and radicand-float != 0 {
      calc.abs(result) * (radicand-uncertainty / calc.abs(radicand-float)) / calc.abs(index-float)
    },
    if index-uncertainty != none {
      calc.abs(result) * calc.abs(calc.ln(radicand-float)) * index-uncertainty / (index-float * index-float)
    },
  )
  let error = if error-terms.any(x => x != none) { rss(error-terms) }

  if index.info.pm == none {
    index.constant = true
  }
  let target-e = get-e(none, result, "value")
  return (
    float: result,
    uncertainty: error,
    info: create-info(result, error, target-e),
    round: get-sig-figs(
      (radicand, index).filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x))),
    ),
    unit: unit,
    constant: (radicand, index).all(x => x.at("constant", default: false)),
    source: (head: "root", data: (radicand, index)),
    args: (radicand, index).map(x => x.at("args", default: none)).sum(),
  )
}

#let sqrt(radicand) = root(radicand, normalise-constant(2))

#let log(value, base) = {
  let value-float = as-float(value)
  let value-uncertainty = as-uncertainty(value)
  let base-float = as-float(base)
  let base-uncertainty = as-uncertainty(base)

  assert(units.is-unitless(value), message: "log: value must not carry a unit.")
  assert(units.is-unitless(base), message: "log: base must not carry a unit.")
  assert(value-float > 0, message: "log: value must be positive.")
  assert(base-float > 0 and base-float != 1, message: "log: base must be positive and != 1.")

  let result = calc.log(value-float, base: base-float)
  let ln-base = calc.ln(base-float)

  let error-terms = (
    if value-uncertainty != none {
      value-uncertainty / (calc.abs(value-float) * calc.abs(ln-base))
    },
    if base-uncertainty != none {
      calc.abs(result) * base-uncertainty / (calc.abs(base-float) * calc.abs(ln-base))
    },
  )
  let error = if error-terms.any(x => x != none) { rss(error-terms) }
  let target-e = get-e(none, result, "value")

  return (
    float: result,
    uncertainty: error,
    info: create-info(result, error, target-e),
    round: get-sig-figs(
      (value, base).filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x))),
    ),
    constant: (value, base).all(x => x.at("constant", default: false)),
    source: (head: "log", data: (value, base)),
    args: (value, base).map(x => x.at("args", default: none)).sum(),
  )
}

#let ln(value) = log(value, e)

#let angle-units = (
  "°": 1deg,
  "rad": 1rad,
  "′": 1deg / 60,
  "″": 1deg / 3600,
)
#let angle-parts(angle, name) = {
  let unit = if units.is-unitless(angle) { "rad" } else { none }
  if unit == none and angle.unit.denominator.len() == 0 and angle.unit.numerator.len() == 1 {
    unit = str(angle.unit.numerator.at(0).at(0))
  }
  assert(
    unit in angle-units,
    message: name + ": angle must not carry a unit other than rad, " + sym.degree + ", " + sym.prime + " or " + sym.prime.double + " (radians assumed without unit).",
  )
  let uncertainty = as-uncertainty(angle)
  (
    value: as-float(angle) * angle-units.at(unit),
    uncertainty: if uncertainty != none { (uncertainty * angle-units.at(unit)).rad() },
  )
}

#let trig-result(name, result, error, angle, target-e) = (
  float: result,
  uncertainty: error,
  info: create-info(result, error, target-e),
  round: get-sig-figs((angle,).filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x)))),
  constant: angle.at("constant", default: false),
  source: (head: name, data: angle),
  args: angle.at("args", default: none),
)

#let snap-zero(result, angle) = if calc.abs(result) < 1e-15 and calc.abs(angle.rad()) > 1e-3 { 0.0 } else { result }

#let sin(angle) = {
  let (value, uncertainty) = angle-parts(angle, "sin")
  let result = snap-zero(calc.sin(value), value)
  let error = if uncertainty != none { calc.abs(calc.cos(value)) * uncertainty }
  trig-result("sin", result, error, angle, 0)
}

#let cos(angle) = {
  let (value, uncertainty) = angle-parts(angle, "cos")
  let result = snap-zero(calc.cos(value), value)
  let error = if uncertainty != none { calc.abs(calc.sin(value)) * uncertainty }
  trig-result("cos", result, error, angle, 0)
}

#let tan(angle) = {
  let (value, uncertainty) = angle-parts(angle, "tan")
  let result = snap-zero(calc.tan(value), value)
  let error = if uncertainty != none { uncertainty / calc.pow(calc.cos(value), 2) }
  trig-result("tan", result, error, angle, get-e(none, result, "value"))
}

#let inverse-trig-result(name, function, derivative, value, unit) = {
  let value-float = as-float(value)
  let value-uncertainty = as-uncertainty(value)
  assert(units.is-unitless(value), message: name + ": value must not carry a unit.")
  // unknown units fall back to degrees, like before
  let divider = angle-units.at(str(unit), default: 1deg)
  let result = function(value-float) / divider
  // the uncertainty is propagated in radians and has to be expressed in the same unit as the result
  let error = if value-uncertainty != none { derivative(value-float) * value-uncertainty * 1rad / divider }
  let target-e = get-e(none, result, "value")
  (
    float: result,
    uncertainty: error,
    info: create-info(result, error, target-e),
    round: get-sig-figs((value,).filter(x => not x.at("constant", default: false)).map(x => (x.info, as-round(x)))),
    unit: (numerator: ((unit, "1"),), denominator: ()),
    constant: value.at("constant", default: false),
    source: (head: name, data: value),
    args: value.at("args", default: none),
  )
}

#let asin(value, unit: sym.degree) = {
  let value-float = as-float(value)
  assert(units.is-unitless(value), message: "asin: value must not carry a unit.")
  assert(value-float >= -1 and value-float <= 1, message: "asin: value must be in [-1, 1].")
  inverse-trig-result("asin", calc.asin, x => 1 / calc.sqrt(1 - x * x), value, unit)
}

#let acos(value, unit: sym.degree) = {
  let value-float = as-float(value)
  assert(units.is-unitless(value), message: "acos: value must not carry a unit.")
  assert(value-float >= -1 and value-float <= 1, message: "acos: value must be in [-1, 1].")
  inverse-trig-result("acos", calc.acos, x => 1 / calc.sqrt(1 - x * x), value, unit)
}

#let atan(value, unit: sym.degree) = inverse-trig-result("atan", calc.atan, x => 1 / (1 + x * x), value, unit)

#let apply-prefix(value, unit, in-numerator) = {
  let prefix = if type(unit.at(0)) != symbol and unit.at(0).len() != 1 { unit.at(0).first() }
  let unit-name = unit.at(0)
  if prefix != none and prefix in prefixes.keys() and not unit-name in units.base-si-units {
    let actual-unit = unit-name.slice(prefix.len())
    if actual-unit in units.base-si-units or actual-unit in units.si-conversions.keys() or actual-unit == "g" {
      unit-name = actual-unit
    } else {
      prefix = none
    }
  } else {
    prefix = none
  }

  if prefix != none {
    let prefix-e = prefixes.at(prefix)
    let removal-unit = (
      numerator: ((if unit-name == "g" { "kg" } else { unit-name }, unit.at(1)),),
      denominator: ((unit.at(0), unit.at(1)),),
    )
    if not in-numerator {
      removal-unit = (numerator: removal-unit.denominator, denominator: removal-unit.numerator)
    }
    let sign = if in-numerator { 1 } else { -1 }
    // grams are converted to kilograms directly: mg = 1e-6 kg
    let correction = if unit-name == "g" { -3 } else { 0 }
    let exponent = (prefix-e + correction) * int(unit.at(1)) * sign
    let multiplier = const(
      (
        float: calc.pow(10, exponent),
        info: (int: "1", frac: "", sign: "+", pm: none, e: str(exponent)),
        unit: removal-unit,
        args: arguments(omit-unity-mantissa: true),
      ),
    )
    value = mul((
      value,
      multiplier,
    ))
  }
  return (value, if prefix != none and unit-name == "g" { "kg" } else { unit-name })
}

#let apply-unit-conversion(value, unit, in-numerator, use-division: false) = {
  let unit-conversion = units.si-conversions.at(unit.at(0), default: none)

  if unit-conversion == none {
    return value
  }

  let factor = unit-conversion.at("factor", default: none)
  let offset = unit-conversion.at("offset", default: none)

  let removal-unit = unit-conversion.unit
  removal-unit.denominator.push(unit)

  let multiplier-value = if factor != none {
    unit-conversion.factor
  } else { "" }

  let multiplier

  if factor != none {
    multiplier = const(
      (
        float: if multiplier-value != "" { float(multiplier-value) } else { 1 },
        info: if multiplier-value != "" { zero.impl.parsing.parse-numeral(multiplier-value) } else {
          (int: "", frac: "", sign: "+", pm: none, e: none)
        },
        unit: (numerator: removal-unit.numerator, denominator: ()),
        args: arguments(omit-unity-mantissa: true),
      ),
    )
    if unit.at(1) != "1" {
      multiplier = pow(multiplier, const(unit.at(1)))
      multiplier.source = none
    }

    let x = const(
      (
        float: 1,
        info: (int: "1", frac: "", sign: "+", pm: none, e: none),
        unit: (numerator: removal-unit.denominator, denominator: ()),
        args: arguments(omit-unity-mantissa: true),
      ),
    )
    if in-numerator {
      multiplier = div(multiplier, x)
    } else {
      multiplier = div(x, multiplier)
    }
  } else {
    if not in-numerator {
      removal-unit = (numerator: removal-unit.denominator, denominator: removal-unit.numerator)
    }
    multiplier = const(
      (
        float: if multiplier-value != "" { float(multiplier-value) } else { 1 },
        info: if multiplier-value != "" { zero.impl.parsing.parse-numeral(multiplier-value) } else {
          (int: "", frac: "", sign: "+", pm: none, e: none)
        },
        unit: removal-unit,
        args: arguments(omit-unity-mantissa: true),
      ),
    )
  }

  value = mul((
    value,
    multiplier,
  ))

  if offset != none and (value.unit.numerator.len() == 1 and value.unit.denominator.len() == 0) {
    value = add((
      value,
      const((
        float: float(offset),
        info: zero.impl.parsing.parse-numeral(offset),
        unit: unit-conversion.unit,
        args: arguments(),
      )),
    ))
  }

  return value
}

#let convert-units-to-si(quantity, save-operations: false) = {
  if units.is-unitless(quantity) { return quantity }
  let result = quantity
  for unit in quantity.unit.numerator {
    (result, unit.at(0)) = apply-prefix(result, unit, true)
    result = apply-unit-conversion(result, unit, true)
  }
  for unit in quantity.unit.denominator {
    (result, unit.at(0)) = apply-prefix(result, unit, false)
    result = apply-unit-conversion(result, unit, false)
  }

  if (result.args.at("exponent", default: none) == "eng") {
    let named = result.args.named()
    named.remove("exponent")
    result.args = arguments(..result.args.pos(), ..named)
  }

  if not save-operations and result != quantity {
    result.source = (head: "mul", data: (quantity,))
  }
  return result
}
#let convert-units(quantity, unit, args: arguments()) = {
  let one = (float: 1, info: (int: "1", frac: "", sign: "+", pm: none, e: none), unit: unit, args: arguments())
  let one-si = convert-units-to-si(one)
  assert(
    not unit.numerator.any(x => units.si-conversions.at(x.at(0), default: (:)).at("offset", default: none) != none),
    message: "convert-units: units with an offset (°C) are not supported as target",
  )
  let si = convert-units-to-si(quantity)
  assert(
    units.equal(si.at("unit", default: none), one-si.at("unit", default: none)),
    message: "convert-units: cannot convert " + repr(quantity.at("unit", default: none)) + " into " + repr(unit),
  )
  let factor = as-float(one-si)
  let result = mul((
    si,
    const((
      float: 1 / factor,
      info: create-info(1 / factor, none, get-e(none, 1 / factor, "value")),
      unit: units.multiply-unit((unit, units.invert-unit(one-si.unit))),
      args: arguments(),
    )),
  ))
  let named = quantity.at("args", default: none)
  named = if named == none { (:) } else { named.named() }
  let _ = named.remove("alt", default: none)
  result.unit = unit
  result.args = arguments(..named, ..args.named())
  result.source = (head: "mul", data: (quantity,))
  return result
}
