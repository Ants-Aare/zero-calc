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

#let create-result-metadata(value, uncertainty, info, unit, source, args) = [#metadata((
  float: value,
  uncertainty: uncertainty,
  info: info,
  unit: unit,
  source: source,
  args: args,
))<calc-result>]

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

#let display(value, error, info, unit, source, args) = {
  let d = if unit == none {
    num(info, ..args)
  } else {
    zi.units.qty(info, unit, ..args)
  }
  ((create-result-metadata(value, error, info, unit, source, args),) + d.children.slice(1)).join()
}

#let add(..terms) = {
  let datas = normalise-quantities(terms.pos(), apply-unit: true)
  let unit = datas.first().at("unit", default: none)
  assert(datas.all(x => x.at("unit", default: none) == unit), message: "All parameters must have the same unit.")
  let result = calc-impl.add(datas, unit)
  let args = arguments(..(terms.named() + datas.first().args.named()))
  return display(..result, args)
}

#let sub(a, ..terms) = {
  let datas = normalise-quantities((a,) + terms.pos(), apply-unit: true)
  let unit = datas.first().at("unit", default: none)
  assert(datas.all(x => x.at("unit", default: none) == unit), message: "All parameters must have the same unit.")

  let result = calc-impl.add(
    (datas.first(),)
      + datas
        .slice(1)
        .map(x => {
          if x.at("float", default: none) != none { x.float = -x.float }
          x.info.sign = if x.info.sign == "-" { "+" } else { "-" }
          x
        }),
    unit,
  )
  let args = arguments(..(terms.named() + datas.first().args.named()))
  return display(..result, args)
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
