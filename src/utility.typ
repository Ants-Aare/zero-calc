#import "lib/zero/src/zero.typ": *
#import impl.utility: *

#let typst-builtin-sequence = ([A] + [ ] + [B]).func()
#let typst-builtin-styled = [#set text(fill: red)].func()
#let typst-builtin-symbol = [--].func()
#let typst-builtin-context = [#context {}].func()
#let typst-builtin-space = [ ].func()

#let symbol-names = (
  math.alpha: "alpha",
  math.Alpha: "Alpha",
  math.beta: "beta",
  math.Beta: "Beta",
  math.gamma: "gamma",
  math.Gamma: "Gamma",
  math.delta: "delta",
  math.Delta: "Delta",
  math.epsilon: "epsilon",
  math.Epsilon: "Epsilon",
  math.zeta: "zeta",
  math.Zeta: "Zeta",
  math.eta: "eta",
  math.Eta: "Eta",
  math.theta: "theta",
  math.Theta: "Theta",
  math.iota: "iota",
  math.Iota: "Iota",
  math.kappa: "kappa",
  math.Kappa: "Kappa",
  math.lambda: "lambda",
  math.Lambda: "Lambda",
  math.mu: "mu",
  math.Mu: "Mu",
  math.nu: "nu",
  math.Nu: "Nu",
  math.xi: "xi",
  math.Xi: "Xi",
  math.omicron: "omicron",
  math.Omicron: "Omicron",
  math.pi: "pi",
  math.Pi: "Pi",
  math.rho: "rho",
  math.Rho: "Rho",
  math.sigma: "sigma",
  math.Sigma: "Sigma",
  math.tau: "tau",
  math.Tau: "Tau",
  math.upsilon: "upsilon",
  math.Upsilon: "Upsilon",
  math.phi: "phi",
  math.Phi: "Phi",
  math.chi: "chi",
  math.Chi: "Chi",
  math.psi: "psi",
  math.Psi: "Psi",
  math.omega: "omega",
  math.Omega: "Omega",
)

#let to-str(content) = {
  if content == none {
    return none
  } else if type(content) == str {
    content
  } else if content.has("text") {
    let alternative-name = symbol-names.at(content.text, default: none)
    if alternative-name != none {
      alternative-name
    } else if (type(content.text) == str) {
      content.text
    } else {
      to-str(content.text)
    }
  } else if content.func() == math.attach {
    (
      to-str(content.base),
      to-str(content.at("b", default: none)),
      to-str(content.at("br", default: none)),
      to-str(content.at("bl", default: none)),
      to-str(content.at("t", default: none)),
      to-str(content.at("tr", default: none)),
      to-str(content.at("tl", default: none)),
    )
      .filter(x => x != none)
      .join("-")
  } else if content.has("children") {
    content.children.map(to-str).join("")
  } else if content.has("body") {
    to-str(content.body)
  } else if content == [ ] {
    "-"
  }
}

#let num-metadata(info, raw, args) = (
  float: if type(raw) != float and type(raw) != int { impl.utility.info-to-float(info) } else { raw },
  uncertainty: impl.utility.info-to-uncertainty(info),
  info: info,
  args: args,
)

#let normalise-quantity(candidate) = {
  let metadata = impl.utility.retrieve-metadata(candidate)
  if metadata != none {
    return metadata
  } else {
    let t = type(candidate)
    if t == dictionary {
      return candidate
    } else if (t == int or t == float or t == str or t == content) {
      return num-metadata(impl.parsing.parse-numeral(candidate), candidate, arguments())
    }
  }
}

#let normalise-constant(candidate) = {
  let metadata = impl.utility.retrieve-metadata(candidate)
  if metadata != none {
    metadata.constant = true
    return metadata
  } else {
    let t = type(candidate)
    if t == dictionary {
      candidate.constant = true
      return candidate
    } else if (t == int or t == float or t == str or t == content) {
      candidate = num-metadata(impl.parsing.parse-numeral(candidate), candidate, arguments())
      candidate.constant = true
      return candidate
    }
  }
}

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

#let as-float(value) = {
  if value.at("float", default: none) != none {
    value.float
  } else if value.raw != none and (type(value.raw) == int or type(value.raw) == float) {
    value.raw
  } else {
    info-to-float(value.info)
  }
}
#let as-uncertainty(value) = {
  if value.at("uncertainty", default: none) != none {
    value.uncertainty
  } else {
    info-to-uncertainty(value.info)
  }
}
#let as-round(value) = {
  let args = value.at("args", default: none)
  if args != none {
    return args.named().at("round", default: value.at("round", default: none))
  }
  return value.at("round", default: none)
}

#let array-as-floats(values) = values.map(as-float)
#let array-as-uncertainties(values) = values.map(as-uncertainty)

#let metadata-as-float(metadata) = {
  let value = retrieve-metadata(metadata)
  if value.at("float", default: none) != none {
    value.float
  } else if value.raw != none and (type(value.raw) == int or type(value.raw) == float) {
    value.raw
  } else {
    info-to-float(value.info)
  }
}
#let metadata-as-uncertainty(metadata) = {
  let value = retrieve-metadata(metadata)
  if value.at("uncertainty", default: none) != none {
    value.uncertainty
  } else {
    info-to-uncertainty(value.info)
  }
}

#let metadatas-as-floats(metadatas) = metadatas.map(retrieve-metadata).map(as-float)
#let metadatas-as-uncertainties(metadatas) = metadatas.map(retrieve-metadata).map(as-uncertainty)

#let get-places(infos, target-e) = {
  if infos == () {
    return none
  }
  let places = infos.map(x => {
    let (info, round) = x
    let e = if info.e == none { 0 } else { int(info.e) }
    let value-frac = info.frac.len()
    let uncertainty = if info.pm != none { info.pm.at(1).len() } else { 1000 }
    if round != none {
      value-frac = round.at("precision", default: value-frac)
      uncertainty = round.at("uncertainty-precision", default: uncertainty)
    }
    return (
      (target-e - e) + value-frac,
      (target-e - e),
      (target-e - e) + uncertainty,
    )
  })

  let value-min-frac = calc.min(..places.map(x => x.at(0)))
  let value-max-int = calc.max(..places.map(x => x.at(1)))
  let value-places = calc.max(value-min-frac, value-max-int)
  let uncertainty-places = calc.min(..places.map(x => x.at(2)))
  let round = (
    precision: value-places,
    mode: "places",
  )
  if uncertainty-places < 900 {
    round += (uncertainty-precision: uncertainty-places)
  }
  return round
}

#let get-sig-figs(infos) = {
  if infos == () {
    return none
  }
  let sig-figs = infos.map(x => {
    let (info, round) = x
    let value = (info.int + info.frac).trim("0", at: start).len()
    let uncertainty = if info.pm != none { (info.pm.at(0) + info.pm.at(1)).trim("0", at: start).len() } else { int.max }
    if round != none {
      value = round.at("precision", default: value)
      uncertainty = round.at("uncertainty-precision", default: uncertainty)
    }
    return (value, uncertainty)
  })
  let value-sig-figs = calc.min(..sig-figs.map(x => x.at(0)))
  let uncertainty-sig-figs = calc.min(..sig-figs.map(x => x.at(1)))
  let round = (
    precision: value-sig-figs,
    mode: "figures",
  )
  if uncertainty-sig-figs != int.max {
    round += (uncertainty-precision: uncertainty-sig-figs)
  }
  return round
}

#let get-highest-e(terms) = calc.max(..terms.map(x => if x.info.e != none { int(x.info.e) } else { 0 }))
#let get-lowest-e(terms) = calc.min(..terms.map(x => if x.info.e != none { int(x.info.e) } else { 0 }))
#let get-value-e(value) = if value != 0 { calc.floor(calc.log(calc.abs(value), base: 10)) } else { 0 }

#let get-e(terms, value, mode) = {
  impl.rounding.assert-option(mode, "e mode", ("highest", "lowest", "value"))
  let e = if mode == "value" {
    let e = get-value-e(value)
    if e == 1 {
      e = 0
    }
    e
  } else if mode == "highest" {
    get-highest-e(terms)
  } else if mode == "highest" {
    get-lowest-e(terms)
  }
  return e
}

#let create-result-metadata(value) = [#metadata(value)<calc-result>]

#let display(value) = {
  let result = if value.at("unit", default: none) == none {
    num(value.info, round: as-round(value), ..value.at("args", default: ()))
  } else {
    zi.units.qty(value.info, value.unit, round: value.round, ..value.at("args", default: ()))
  }
  ((create-result-metadata(value),) + result.children.slice(1)).join()
}
