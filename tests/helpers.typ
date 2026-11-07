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
