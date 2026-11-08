/// [skip]
// BUG: units with fractional exponents (from sqrt/root/pow) can not be used in further calculations.
//
// sqrt(m) gives the unit `m^0.5`, but units-to-signed-pairs parses every exponent with int(), so any
// further multiplication, division or power panics: `int("0.5")`.
// The results should be m (sqrt(m)*sqrt(m)) and m^2 (cbrt(m^2)^3).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sqrt(m) * sqrt(m)
  zi.declare("m^2")("9.0"),
  // 2: sqrt(m)^2
  zi.m("9.0"),
  // 3: cbrt(m^2)^3
  zi.declare("m^2")("8.0"),
  // 4: m^0.5 / m^0.5
  num("1.5"),
)
