// zcalc.mul: results keep the number of significant figures of the least precise factor.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 2 * 3
  num("6"),
  // 2: sig figs of the least precise factor
  num("6.0"),
  // 3: rounding to 2 sig figs
  num("98"),
  // 4: rounding to 2 sig figs, 4 digits
  num("9.8e3"),
  // 5: zero factor
  num("0"),
  // 6: single factor
  num("5.0"),
  // 7: single factor with uncertainty
  num("5.0+-0.1"),
  // 8: negative * negative
  num("6.0"),
  // 9: negative * positive
  num("-6.0"),
  // 10: three factors
  num("8.1"),
  // 11: exponents cancel
  num("1"),
  // 12: exponents add
  num("3.0e6"),
  // 13: tiny result
  num("1e-6"),
  // 14: two digit exponent notation 10..99 stays plain
  num("45"),
  // 15: 100 and above uses exponent notation
  num("1.1e2"),
  // 16: below one uses exponent notation
  num("3e-1"),
  // 17: float arguments
  num("3"),
  // 18: int arguments
  num("40"),
  // 19: constant does not limit precision
  num("6.0"),
  // 20: pi is a constant
  num("6.3"),
  // 21: integer constant times pi
  num("6.28318530718"),
  // 22: relative uncertainties add in quadrature
  num("2.0+-0.3e2"),
  // 23: negative product keeps a positive uncertainty
  num("-2.0+-0.3e2"),
  // 24: uncertainty on one factor
  num("30+-2"),
  // 25: uncertainty decides value rounding
  num("10.0+-0.1"),
  // 26: large uncertainty
  num("2.47+-0.60e2"),
  // 27: three factors with uncertainty
  num("9.0+-0.5"),
  // 28: units multiply
  zi.declare("m s")("6.0"),
  // 29: units square
  zi.declare("m^2")("6.0"),
  // 30: units partly cancel
  zi.m("6.0"),
  // 31: compound unit cancels
  zi.m("10"),
  // 32: quantity * plain number
  zi.m("6.0"),
  // 33: plain number * quantity
  zi.m("6.0"),
  // 34: plain number * quantity * quantity
  zi.declare("m s")("6.0"),
  // 35: units with uncertainty
  zi.declare("m s")("6.0+-0.4"),
  // 36: convert-si: km * h
  zi.declare("m s")("4e7"),
  // 37: convert-si: g * (mol/g)
  zi.mol("5"),
  // 38: convert-si: m * cm
  zi.declare("m^2")("1.0e-1"),
  // 39: convert-si: kg * g
  zi.declare("kg^2")("1.0e-2"),
  // 40: convert-si with call-site exponent
  zi.declare("kg m^2 s^-2")("9.0e3", exponent: "eng"),
  // 41: result of mul as input
  num("24"),
  // 42: mul of add
  num("40"),
  // 43: mul of add with uncertainty
  num("35+-3"),
  // 44: uncertainty on the second factor
  num("44+-2"),
  // 45: keep full uncertainty digits
  num("66+-0.003702", round: (follow-uncertainty: false)),
  // 46: exponent notation in both factors
  num("60"),
  // 47: integers
  num("40"),
  // 48: tiny numbers
  num("6.0e-7"),
  // 49: uncertainty with exponent
  num("1+-0.004e2"),
  // 50: trailing zeros count
  num("21"),
  // 51: four factors with uncertainty
  num("30+-2"),
  // 52: negative with uncertainty
  num("-15+-0.6"),
  // 53: uncertainty digits decide the value digits
  num("35.0+-0.7"),
  // 54: both factors uncertain
  num("35+-6"),
  // 55: two significant figures
  num("35"),
  // 56: big exponent notation
  num("1.7e5"),
  // 57: 9.9 * 10.1
  num("1.0e2"),
  // 58: 9.5 * 10.5
  num("1.0e2"),
  // 59: m * m^-1
  num("6.0"),
  // 60: mul(0 +- 1, 5)
  num("0+-5"),
  // 61: mul(5, 0 +- 1)
  num("0+-5"),
  // 62: mul(0.0 +- 0.1, 3.0 +- 0.1)
  num("0.0+-0.3"),
)
