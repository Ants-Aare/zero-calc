// zcalc.pow: significant figures, uncertainty of base and exponent, unit exponents.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 2^3
  zcalc.pow("2", "3"),
  // 2: integer exponent is exact: 2.0^3
  zcalc.pow("2.0", "3"),
  // 3: decimal exponent limits sig figs: 2^3.0
  zcalc.pow("2", "3.0"),
  // 4: decimal exponent: 2.00^3.0
  zcalc.pow("2.00", "3.0"),
  // 5: negative exponent
  check(zcalc.pow("2.0", "-2"), float: 0.25),
  // 6: exponent zero
  zcalc.pow("2.0", "0"),
  // 7: zero base
  zcalc.pow("0.0", "2"),
  // 8: exponent one
  zcalc.pow("5.0", "1"),
  // 9: one to a large power
  zcalc.pow("1.0", "100"),
  // 10: negative base, odd exponent
  zcalc.pow("-2.0", "3"),
  // 11: negative base, even exponent
  zcalc.pow("-2.0", "2"),
  // 12: fractional exponent
  check(zcalc.pow("4.0", "0.5"), float: 2),
  // 13: base with two sig figs
  zcalc.pow("10", "6"),
  // 14: negative power of ten
  zcalc.pow("10.0", "-3"),
  // 15: exponent notation in base
  check(zcalc.pow("1.5e3", "2"), float: 2.25e6),
  // 16: tiny base
  zcalc.pow("1e-3", "2"),
  // 17: very large result
  zcalc.pow("10", "300"),
  // 18: original: 22.12^2
  check(zcalc.pow("22.12", "2"), float: 22.12*22.12),
  // 19: float arguments
  check(zcalc.pow(2.5, 2), float: 6.25),
  // 20: constant base
  zcalc.pow(zcalc.const("3"), "2"),
  // 21: result of pow as input
  check(zcalc.pow(zcalc.pow("2.0", "3"), "2"), float: 64),
  // 22: uncertainty of the base: x^2
  check(zcalc.pow("3.0+-0.1", "2"), float: 9, uncertainty: 0.6),
  // 23: uncertainty of the base: x^3
  check(zcalc.pow("3.0+-0.1", "3"), float: 27, uncertainty: 2.7),
  // 24: negative base with uncertainty
  check(zcalc.pow("-3.0+-0.1", "3"), float: -27, uncertainty: 2.7),
  // 25: negative exponent with uncertainty
  check(zcalc.pow("3.0+-0.1", "-2"), float: 0.1111111111111111, uncertainty: 0.007407407407407408),
  // 26: uncertainty of the exponent
  check(zcalc.pow("2.0", "3.0+-0.1"), float: 8, uncertainty: 0.5545177444479562),
  // 27: uncertainty of base and exponent
  check(zcalc.pow("2.0+-0.1", "3.0+-0.1"), float: 8, uncertainty: 1.3219265973977712),
  // 28: base == 1 has no exponent sensitivity
  check(zcalc.pow("1.0", "2.0+-0.1"), float: 1, uncertainty: 0),
  // 29: existing: 22.12^(2+-0.1)
  check(zcalc.pow("22.12", "2+-0.1"), float: 489.29440000000005, uncertainty: 151.50913887366787),
  // 30: unit squared
  zcalc.pow(zi.m("3.0"), "2"),
  // 31: unit inverted
  zcalc.pow(zi.m("3.0"), "-1"),
  // 32: compound unit squared
  zcalc.pow(zi.declare("m/s")("3.0"), "2"),
  // 33: unit with uncertainty
  zcalc.pow(zi.m("3.0+-0.1"), "2"),
  // 34: unit square root via 0.5
  zcalc.pow(zi.declare("m^2")("9.0"), "0.5"),
  // 35: convert-si converts the base
  check(zcalc.pow(zi.cm("2.0"), "2", convert-si: true), float: 4e-4),
  // 36: integer-looking decimal exponent: 22.12^2.0
  check(zcalc.pow("22.12", "2.0"), float: 489.2944),
  // 37: m^0
  zcalc.pow(zi.m("3.0"), "0"),
  // 38: 5.0 ^ 0.0
  check(zcalc.pow("5.0", "0.0"), float: 1),
  // 39: pow(0.0 +- 0.1, 1)
  check(zcalc.pow("0.0+-0.1", "1"), float: 0, uncertainty: 0.1),
  // 40: pow(0.0 +- 0.1, 2) is 0 +- 0
  check(zcalc.pow("0.0+-0.1", "2"), float: 0, uncertainty: 0),
)
