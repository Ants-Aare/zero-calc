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
#import "operations.typ" as calc-impl

#let pi = calc.pi
#let e = calc.e
#let tau = calc.tau
#let inf = calc.inf

#let num-metadata(info, raw, args) = (
  float: if type(raw) != float and type(raw) != int { impl.utility.info-to-float(info) } else { raw },
  uncertainty: impl.utility.info-to-uncertainty(info),
  info: info,
  args: args,
)

#let create-result-metadata(value) = [#metadata(value)<calc-result>]

#let normalise-quantities(quantities, apply-unit: false) = {
  let datas = ()
  let unit
  for candidate in quantities {
    let metadata = impl.utility.retrieve-metadata(candidate)
    if metadata != none {
      datas.push(metadata)
      unit = metadata.at("unit", default: none)
    } else {
      let t = type(candidate)
      if t == dictionary {
        datas.push(candidate)
      } else if (t == int or t == float or t == str or t == content) {
        let data = num-metadata(impl.parsing.parse-numeral(candidate), candidate, arguments())
        if apply-unit and unit != none {
          data += (unit: unit)
        }
        datas.push(data)
      }
    }
  }
  return (datas)
}

#let display(value) = {
  let result = if value.unit == none {
    num(value.info, round: value.round, ..value.args)
  } else {
    zi.units.qty(value.info, value.unit, round: value.round, ..value.args)
  }
  ((create-result-metadata(value),) + result.children.slice(1)).join()
}

#let add(..terms) = {
  let datas = normalise-quantities(terms.pos(), apply-unit: true)
  let result = calc-impl.add(datas)
  result += (args: arguments(..(terms.named() + datas.first().args.named())))
  return display(result)
}

#let sub(a, ..terms) = {
  let datas = normalise-quantities((a,) + terms.pos(), apply-unit: true)
  let result = calc-impl.sub(datas.first(), datas.slice(1))
  result += (args: arguments(..(terms.named() + datas.first().args.named())))
  return display(result)
}

#let abs(a, ..args) = {
  let data = normalise-quantities((a,)).at(0)
  data.float = calc.abs(data.float)
  data.info.sign = "+"
  return display(
    data.float,
    data.uncertainty,
    data.info,
    data.at("unit", default: none),
    source: (op: "abs", data: data),
    ..args,
  )
}

#let mul(..terms) = {
  let datas = normalise-quantities(terms.pos())
  let result = calc-impl.mul(datas)
  let args = arguments(..(terms.named() + datas.first().args.named()))
  return display(..result, args)
}

#let div(dividend, divisor, ..args) = {
  let (dividend, divisor) = normalise-quantities((dividend, divisor))
  let result = calc-impl.div(dividend, divisor)
  let args = arguments(..(args.named() + dividend.args.named()))
  return display(..result, args)
}

#let pow(base, exp, ..args) = {
  let (base, exp) = normalise-quantities((base, exp))
  let result = calc-impl.pow(base, exp)
  let args = arguments(..(args.named() + base.args.named()))
  return display(..result, args)
}
