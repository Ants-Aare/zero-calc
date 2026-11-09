#import "@preview/zero:0.7.1": *

#let cases(..items) = items.pos().join(pagebreak())
#let check(x, float: auto, uncertainty: auto, tolerance: 1e-9) = {
  let data = impl.utility.retrieve-metadata(x)
  let close(a, b) = {
    if a == none or b == none { return a == b }
    calc.abs(a - b) <= tolerance * calc.max(1.0, calc.abs(b))
  }
  let float-ok = float == auto or close(data.at("float", default: none), float)
  let uncertainty-ok = uncertainty == auto or close(data.at("uncertainty", default: none), uncertainty)
  if float-ok and uncertainty-ok { return x }
  text(fill: red)[
    check failed: float = #repr(data.at("float", default: none)) (expected #repr(float)),
    uncertainty = #repr(data.at("uncertainty", default: none)) (expected #repr(uncertainty))
  ]
}

// check-args: the named arguments that a result carries on to zero (alt, exponent, ...). `absent` lists keys that must not be there.
#let check-args(x, expected: (:), absent: ()) = {
  let named = impl.utility.retrieve-metadata(x).args.named()
  let ok = expected.pairs().all(((k, v)) => named.at(k, default: none) == v) and absent.all(k => k not in named)
  if ok { return x }
  text(fill: red)[check failed: arguments are #repr(named), expected #repr(expected) without #repr(absent)]
}

// check-round: the rounding a result stores (the same parameters for every operation).
#let check-round(x, precision: auto, uncertainty-precision: auto, mode: "figures") = {
  let round = impl.utility.retrieve-metadata(x).at("round", default: none)
  let get(key) = if round == none { none } else { round.at(key, default: none) }
  let ok = (
    (mode == auto or get("mode") == mode)
      and (precision == auto or get("precision") == precision)
      and (uncertainty-precision == auto or get("uncertainty-precision") == uncertainty-precision)
  )
  if ok { return x }
  text(fill: red)[check failed: round is #repr(round), expected #repr((mode: mode, precision: precision, uncertainty-precision: uncertainty-precision))]
}

// same: both results have the same digits and the same rounding, `a` is shown.
#let same(a, b) = {
  let (x, y) = (impl.utility.retrieve-metadata(a), impl.utility.retrieve-metadata(b))
  if x.round == y.round and x.info == y.info and x.float == y.float { return a }
  text(fill: red)[check failed: #repr((x.round, x.info)) differs from #repr((y.round, y.info))]
}
