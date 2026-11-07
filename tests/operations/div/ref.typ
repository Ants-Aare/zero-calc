// zcalc.div: significant figures of the least precise operand, relative uncertainties in quadrature.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 6 / 3
  num("2"),
  // 2: 1 / 3 (1 sig fig)
  num("3e-1"),
  // 3: 1.0 / 3 (limited by the divisor)
  num("3e-1"),
  // 4: 1.00 / 3.000
  num("3.33e-1"),
  // 5: negative dividend
  num("-3.3e-1"),
  // 6: negative divisor
  num("-3.3e-1"),
  // 7: negative / negative
  num("3.3e-1"),
  // 8: zero dividend
  num("0"),
  // 9: 100 / 10 keeps trailing zeros as significant
  num("10"),
  // 10: exponents subtract
  num("1e3"),
  // 11: exponents subtract (negative)
  num("3.8e4"),
  // 12: existing: 2.49 / 4.0
  num("6.2e-1"),
  // 13: existing: 22 / 2
  num("10"),
  // 14: result above 100
  num("2.5e2"),
  // 15: float arguments
  num("3e-1"),
  // 16: constant divisor
  num("2.50"),
  // 17: pi divided by a number
  num("1.6"),
  // 18: README example without units
  num("6.0+-0.5"),
  // 19: uncertainty on the dividend only
  num("7.3333333+-0.0004113"),
  // 20: uncertainty on the divisor only
  num("2.50+-0.06e-1"),
  // 21: negative quotient has a positive uncertainty
  num("-2.0+-0.1"),
  // 22: large uncertainty
  num("62+-15"),
  // 23: README example: m / s
  zi.declare("m/s")("6.0+-0.5"),
  // 24: unit in the denominator
  zi.declare("s^-1")("2.5e-1"),
  // 25: quantity / plain number
  zi.m("2.5e-1"),
  // 26: dividing by a compound unit
  zi.s("2.5e-1"),
  // 27: m / m^2
  zi.declare("m^-1")("2.0"),
  // 28: compound dividend
  zi.declare("kg m s^-1")("2.0"),
  // 29: convert-si: km / h
  zi.declare("m/s")("17"),
  // 30: convert-si: g / mL
  zi.declare("kg/m^3")("2.5e3"),
  // 31: quotient of quotients
  num("2.0"),
  // 32: div of add
  num("4.0"),
  // 33: uncertainty on the divisor, 2 vs 1 sig fig
  num("11.0+-0.6"),
  // 34: exponent notation in the dividend
  num("33"),
  // 35: tiny numbers
  num("6.7"),
  // 36: uncertainty with exponent
  num("2.50+-0.01e-3"),
  // 37: negative dividend with uncertainty
  num("-1.67+-0.07"),
  // 38: quantities with uncertainty
  zi.declare("m/s")("2.32+-0.10"),
)
