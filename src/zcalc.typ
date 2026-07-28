// calc.typ
// planned for now:
// add +
// sub +
// abs +
// mul +
// div +
// pow
// root
// exp
// sqrt
// sin/cos/tan
// log
// ln
#import "lib/zero/src/zero.typ": *
#import "operations.typ"
#import "utility.typ"

#let pi = calc.pi
#let e = calc.e
#let tau = calc.tau
#let inf = calc.inf

#let declare-constant(value, ..args) = {
  let result = normalise-constant(value)
  result += (args: arguments(..(terms.named() + datas.first().args.named())))
  utility.display(result)
}

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

#let abs(a, ..args) = {
  let data = utility.normalise-quantities((a,)).at(0)
  data.float = calc.abs(data.float)
  data.info.sign = "+"
  return utility.display(
    data.float,
    data.uncertainty,
    data.info,
    data.at("unit", default: none),
    source: (op: "abs", data: data),
    ..args,
  )
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
  result += (args: arguments(..(terms.named() + datas.first().args.named())))
  return utility.display(result)
}

#let pow(base, exp, ..args) = {
  let (base, exp) = utility.normalise-quantities((base, exp))
  let result = operations.pow(base, exp)
  let args = arguments(..(args.named() + base.args.named()))
  return utility.display(..result, args)
}
