#import "operations.typ"
#import "utility.typ"
#import "display.typ"

#let const(value) = {
  let result = utility.normalise-constant(value)
  display.display-info(result)
}

#let pi = const(calc.pi)
#let e = const(calc.e)
#let tau = const(calc.tau)
#let inf = const(calc.inf)

#let add(convert-si: false, ..summands) = {
  let datas = utility.normalise-quantities(summands.pos(), apply-unit: true)
  if convert-si { datas = datas.map(operations.convert-units-to-si) }
  let result = operations.add(datas)
  result += (args: arguments(..(summands.named() + datas.first().args.named())))
  return display.display-info(result)
}

#let sub(minuend, convert-si: false, ..subtrahends) = {
  let datas = utility.normalise-quantities((minuend,) + subtrahends.pos(), apply-unit: true)
  if convert-si { datas = datas.map(operations.convert-units-to-si) }
  let result = operations.sub(datas.first(), datas.slice(1))
  result += (args: arguments(..(subtrahends.named() + datas.first().args.named())))
  return display.display-info(result)
}

#let abs(value, convert-si: false, ..args) = {
  let value = utility.normalise-quantity(value)
  if convert-si { value = operations.convert-units-to-si(value) }
  let result = operations.abs(value)
  result += (args: arguments(..(args.named() + value.args.named())))
  return display.display-info(result)
}
#let neg(value, convert-si: false, ..args) = {
  let value = utility.normalise-quantity(value)
  if convert-si { value = operations.convert-units-to-si(value) }
  let result = operations.neg(value)
  result += (args: arguments(..(args.named() + value.args.named())))
  return display.display-info(result)
}

#let mul(convert-si: false, ..factors) = {
  let datas = utility.normalise-quantities(factors.pos())
  if convert-si { datas = datas.map(operations.convert-units-to-si) }
  let result = operations.mul(datas)
  result += (args: arguments(..(factors.named() + datas.first().args.named())))
  return display.display-info(result)
}

#let div(dividend, divisor, convert-si: false, ..args) = {
  let (dividend, divisor) = utility.normalise-quantities((dividend, divisor))
  if convert-si {
    (dividend, divisor) = (operations.convert-units-to-si(dividend), operations.convert-units-to-si(divisor))
  }
  let result = operations.div(dividend, divisor)
  result += (args: arguments(..(args.named() + dividend.args.named())))
  return display.display-info(result)
}

#let pow(base, exponent, convert-si: false, ..args) = {
  let (base, exponent) = utility.normalise-quantities((base, exponent))
  if convert-si { base = operations.convert-units-to-si(base) }
  let result = operations.pow(base, exponent)
  result += (args: arguments(..(args.named() + base.args.named())))
  return display.display-info(result)
}

#let exp(exponent, convert-si: false, ..args) = {
  let exponent = utility.normalise-quantity(exponent)
  let result = operations.exp(exponent)
  result += (args: arguments(..(args.named() + exponent.args.named())))
  return display.display-info(result)
}

#let root(radicand, index, convert-si: false, ..args) = {
  let (radicand, index) = utility.normalise-quantities((radicand, index))
  if convert-si {
    (radicand, index) = (operations.convert-units-to-si(radicand), operations.convert-units-to-si(index))
  }
  let result = operations.root(radicand, index)
  result += (args: arguments(..(args.named() + radicand.args.named())))
  return display.display-info(result)
}

#let sqrt(radicand, convert-si: false, ..args) = {
  let radicand = utility.normalise-quantity(radicand)
  let result = operations.sqrt(radicand)
  result += (args: arguments(..(args.named() + radicand.args.named())))
  return display.display-info(result)
}

#let log(value, base, ..args) = {
  let (value, base) = utility.normalise-quantities((value, base))
  let result = operations.log(value, base)
  result += (args: arguments(..(args.named() + value.args.named())))
  return display.display-info(result)
}

#let ln(value, ..args) = {
  let value = utility.normalise-quantity(value)
  let result = operations.sqrt(value)
  result += (args: arguments(..(args.named() + value.args.named())))
  return display.display-info(result)
}

#let sin(angle, ..args) = {
  let angle = utility.normalise-quantity(angle)
  let result = operations.sin(angle)
  result += (args: arguments(..(args.named() + angle.args.named())))
  return display.display-info(result)
}
#let cos(angle, ..args) = {
  let angle = utility.normalise-quantity(angle)
  let result = operations.cos(angle)
  result += (args: arguments(..(args.named() + angle.args.named())))
  return display.display-info(result)
}
#let tan(angle, ..args) = {
  let angle = utility.normalise-quantity(angle)
  let result = operations.tan(angle)
  result += (args: arguments(..(args.named() + angle.args.named())))
  return display.display-info(result)
}

#let asin(value, unit: sym.degree, ..args) = {
  let value = utility.normalise-quantity(value)
  let result = operations.asin(value, unit: unit)
  result += (args: arguments(..(args.named() + value.args.named())))
  return display.display-info(result)
}
#let acos(value, unit: sym.degree, ..args) = {
  let value = utility.normalise-quantity(value)
  let result = operations.acos(value, unit: unit)
  result += (args: arguments(..(args.named() + value.args.named())))
  return display.display-info(result)
}
#let atan(value, unit: sym.degree, ..args) = {
  let value = utility.normalise-quantity(value)
  let result = operations.atan(value, unit: unit)
  result += (args: arguments(..(args.named() + value.args.named())))
  return display.display-info(result)
}

#let convert-units-to-si(quantity, save-operations: true) = {
  let value = utility.normalise-quantity(quantity)
  value = operations.convert-units-to-si(value, save-operations: save-operations)
  return display.display-info(value)
}

#let set-preferred-units(rules) = context {
  let state = utility.zcalc-state.get()
  let normalise-unit(unit) = {
    let type = type(unit)
    return if type == function {
      let metadata = utility.impl.utility.retrieve-metadata(unit())
      (unit: metadata.unit, alt: metadata.args.named().at("alt", default: auto))
    } else if type == dictionary {
      if unit.at("denominator", default: none) != none and unit.at("numerator", default: none) != none {
        (unit: unit, alt: none)
      } else {
        unit
      }
    } else if type(unit) == content {
      let metadata = utility.impl.utility.retrieve-metadata(unit) //.at("unit", default: none)
      (unit: metadata.unit, alt: metadata.args.named().at("alt", default: auto))
    }
  }
  let new-state = (
    preferred-units: rules.map(rule => (
      match: normalise-unit(rule.match),
      preferred: normalise-unit(rule.preferred),
      exact-match: rule.at("exact-match", default: true),
      factor: rule.at("factor", default: none),
    )),
  )

  state += new-state

  utility.zcalc-state.update(state)
}
