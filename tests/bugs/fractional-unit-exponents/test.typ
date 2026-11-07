/// [skip]
// BUG: units with fractional exponents (from sqrt/root/pow) can not be used in further calculations.
//
// sqrt(m) gives the unit `m^0.5`, but units-to-signed-pairs parses every exponent with int(), so any
// further multiplication, division or power panics: `int("0.5")`.
// The results should be m (sqrt(m)*sqrt(m)) and m^2 (cbrt(m^2)^3).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sqrt(m) * sqrt(m)
  zcalc.mul(zcalc.sqrt(zi.declare("m^2")("9.0")), zcalc.sqrt(zi.declare("m^2")("9.0"))),
  // 2: sqrt(m)^2
  zcalc.pow(zcalc.sqrt(zi.m("9.0")), "2"),
  // 3: cbrt(m^2)^3
  zcalc.pow(zcalc.root(zi.declare("m^2")("8.0"), "3"), "3"),
  // 4: m^0.5 / m^0.5
  zcalc.div(zcalc.sqrt(zi.m("9.0")), zcalc.sqrt(zi.m("4.0"))),
)
