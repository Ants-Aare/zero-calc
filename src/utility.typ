#import "lib/zero/src/zero.typ": *
#import impl.utility: *

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
  let places = infos.map(x => {
    let (info, round) = x
    let e = if info.e == none { 0 } else { int(info.e) }
    let value-frac = info.frac.len()
    let uncertainty = if info.pm != none { (target-e - e) + info.pm.at(1).len() } else { int.max }
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
  if uncertainty-places != int.max {
    round += (uncertainty-precision: uncertainty-places)
  }
  return round
}

#let get-sig-figs(infos) = {
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
