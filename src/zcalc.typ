#import "operations.typ"
#import "utility.typ"

#let const(value) = {
  let result = utility.normalise-constant(value)
  utility.display(result)
}

#let pi = const(calc.pi)
#let e = const(calc.e)
#let tau = const(calc.tau)
#let inf = const(calc.inf)


#let add(..terms) = {
  let datas = utility.normalise-quantities(terms.pos(), apply-unit: true)
  let result = operations.add(datas)
  result += (args: arguments(..(terms.named() + datas.first().args.named())))
  return utility.display(result)
}

#let sub(a, ..terms) = {
  let datas = utility.normalise-quantities((a,) + terms.pos(), apply-unit: true)
  let result = operations.sub(datas.first(), datas.slice(1))
  result += (args: arguments(..(terms.named() + datas.first().args.named())))
  return utility.display(result)
}

#let abs(value, ..args) = {
  let value = utility.normalise-quantity(value)
  let result = operations.abs(value)
  result += (args: arguments(..(args.named() + value.args.named())))
  return utility.display(result)
}
#let neg(value, ..args) = {
  let value = utility.normalise-quantity(value)
  let result = operations.neg(value)
  result += (args: arguments(..(args.named() + value.args.named())))
  return utility.display(result)
}

#let mul(..terms) = {
  let datas = utility.normalise-quantities(terms.pos())
  let result = operations.mul(datas)
  result += (args: arguments(..(terms.named() + datas.first().args.named())))
  return utility.display(result)
}

#let div(dividend, divisor, ..args) = {
  let (dividend, divisor) = utility.normalise-quantities((dividend, divisor))
  let result = operations.div(dividend, divisor)
  result += (args: arguments(..(args.named() + dividend.args.named())))
  return utility.display(result)
}

#let pow(base, exp, ..args) = {
  let (base, exp) = utility.normalise-quantities((base, exp))
  let result = operations.pow(base, exp)
  result += (args: arguments(..(args.named() + base.args.named())))
  return utility.display(result)
}
#let exp(exp, ..args) = {
  let exp = utility.normalise-quantity(exp)
  let result = operations.exp(exp)
  result += (args: arguments(..(args.named() + exp.args.named())))
  return utility.display(result)
}

#let root(radicand, index, ..args) = {
  let (radicand, index) = utility.normalise-quantities((radicand, index))
  let result = operations.root(radicand, index)
  result += (args: arguments(..(args.named() + radicand.args.named())))
  return utility.display(result)
}

#let sqrt(radicand, ..args) = {
  let radicand = utility.normalise-quantity(radicand)
  let result = operations.sqrt(radicand)
  result += (args: arguments(..(args.named() + radicand.args.named())))
  return utility.display(result)
}

#let log(value, base, ..args) = {
  let (value, base) = utility.normalise-quantities((value, base))
  let result = operations.log(value, base)
  result += (args: arguments(..(args.named() + value.args.named())))
  return utility.display(result)
}

#let ln(value, ..args) = {
  let value = utility.normalise-quantity(value)
  let result = operations.sqrt(value)
  result += (args: arguments(..(args.named() + value.args.named())))
  return utility.display(result)
}

#let sin(angle, ..args) = {
  let angle = utility.normalise-quantity(angle)
  let result = operations.sin(angle)
  result += (args: arguments(..(args.named() + angle.args.named())))
  return utility.display(result)
}
#let cos(angle, ..args) = {
  let angle = utility.normalise-quantity(angle)
  let result = operations.cos(angle)
  result += (args: arguments(..(args.named() + angle.args.named())))
  return utility.display(result)
}
#let tan(angle, ..args) = {
  let angle = utility.normalise-quantity(angle)
  let result = operations.tan(angle)
  result += (args: arguments(..(args.named() + angle.args.named())))
  return utility.display(result)
}

