// zcalc.pow: significant figures, uncertainty of base and exponent, unit exponents.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 2^3
  num("8"),
  // 2: integer exponent is exact: 2.0^3
  num("8.0"),
  // 3: decimal exponent limits sig figs: 2^3.0
  num("8"),
  // 4: decimal exponent: 2.00^3.0
  num("8.0"),
  // 5: negative exponent
  num("2.5e-1"),
  // 6: exponent zero
  num("1.0"),
  // 7: zero base
  num("0"),
  // 8: exponent one
  num("5.0"),
  // 9: one to a large power
  num("1.0"),
  // 10: negative base, odd exponent
  num("-8.0"),
  // 11: negative base, even exponent
  num("4.0"),
  // 12: fractional exponent
  num("2"),
  // 13: base with two sig figs
  num("1.0e6"),
  // 14: negative power of ten
  num("1.00e-3"),
  // 15: exponent notation in base
  num("2.3e6"),
  // 16: tiny base
  num("1e-6"),
  // 17: very large result
  num("1.0e300"),
  // 18: original: 22.12^2
  num("4.893e2"),
  // 19: float arguments
  num("6.3"),
  // 20: constant base
  num("9"),
  // 21: result of pow as input
  num("64"),
  // 22: uncertainty of the base: x^2
  num("9.0+-0.6"),
  // 23: uncertainty of the base: x^3
  num("27+-3"),
  // 24: negative base with uncertainty
  num("-27+-3"),
  // 25: negative exponent with uncertainty
  num("1.11+-0.07e-1"),
  // 26: uncertainty of the exponent
  num("8.0+-0.6"),
  // 27: uncertainty of base and exponent
  num("8+-1"),
  // 28: base == 1 has no exponent sensitivity
  num("1.0+-0.0"),
  // 29: existing: 22.12^(2+-0.1)
  num("5+-2e2"),
  // 30: unit squared
  zi.declare("m^2")("9.0"),
  // 31: unit inverted
  zi.declare("m^-1")("3.3e-1"),
  // 32: compound unit squared
  zi.declare("m^2 s^-2")("9.0"),
  // 33: unit with uncertainty
  zi.declare("m^2")("9.0+-0.6"),
  // 34: unit square root via 0.5
  zi.m("3"),
  // 35: convert-si converts the base
  zi.declare("m^2")("4.0e-4"),
  // 36: integer-looking decimal exponent: 22.12^2.0
  num("4.9e2"),
)
