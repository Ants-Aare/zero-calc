// zcalc.mul: results keep the number of significant figures of the least precise factor.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 2 * 3
  zcalc.mul("2", "3"),
  // 2: sig figs of the least precise factor
  zcalc.mul("2.0", "3.00"),
  // 3: rounding to 2 sig figs
  zcalc.mul("9.9", "9.9"),
  // 4: rounding to 2 sig figs, 4 digits
  zcalc.mul("99", "99"),
  // 5: zero factor
  zcalc.mul("0", "5"),
  // 6: single factor
  zcalc.mul("5.0"),
  // 7: single factor with uncertainty
  zcalc.mul("5.0+-0.1"),
  // 8: negative * negative
  zcalc.mul("-2.0", "-3.0"),
  // 9: negative * positive
  zcalc.mul("-2.0", "3.0"),
  // 10: three factors
  check(zcalc.mul("1.1", "2.22", "3.333"), float: 1.1*2.22*3.333),
  // 11: exponents cancel
  zcalc.mul("1e3", "1e-3"),
  // 12: exponents add
  zcalc.mul("1.5e3", "2.0e3"),
  // 13: tiny result
  zcalc.mul("0.001", "0.001"),
  // 14: two digit exponent notation 10..99 stays plain
  zcalc.mul("5.0", "9.0"),
  // 15: 100 and above uses exponent notation
  zcalc.mul("5.0", "21.0"),
  // 16: below one uses exponent notation
  zcalc.mul("0.5", "0.5"),
  // 17: float arguments
  zcalc.mul(1.5, 2.0),
  // 18: int arguments
  zcalc.mul(6, 7),
  // 19: constant does not limit precision
  zcalc.mul("2.0", zcalc.const("3")),
  // 20: pi is a constant
  check(zcalc.mul("2.0", zcalc.pi), float: 2*calc.pi),
  // 21: integer constant times pi
  zcalc.mul(zcalc.const("2"), zcalc.pi),
  // 22: relative uncertainties add in quadrature
  check(zcalc.mul("10+-1", "20+-2"), float: 200, uncertainty: 28.284271247461906),
  // 23: negative product keeps a positive uncertainty
  check(zcalc.mul("-10+-1", "20+-2"), float: -200, uncertainty: 28.284271247461906),
  // 24: uncertainty on one factor
  check(zcalc.mul("10.0+-0.5", "3.0"), float: 30, uncertainty: 1.5),
  // 25: uncertainty decides value rounding
  check(zcalc.mul("2.49+-0.03", "4.0"), float: 9.96, uncertainty: 0.12),
  // 26: large uncertainty
  check(zcalc.mul("123.456+-30", "2"), float: 246.912, uncertainty: 60),
  // 27: three factors with uncertainty
  check(zcalc.mul("2.0+-0.1", "3.00+-0.05", "1.5"), float: 9, uncertainty: 0.47434164902525694),
  // 28: units multiply
  zcalc.mul(zi.m("2.0"), zi.s("3.0")),
  // 29: units square
  zcalc.mul(zi.m("2.0"), zi.m("3.0")),
  // 30: units partly cancel
  zcalc.mul(zi.m("2.0"), zi.declare("m^-1")("3.0"), zi.m("1.0")),
  // 31: compound unit cancels
  zcalc.mul(zi.declare("m/s")("5.0"), zi.s("2.0")),
  // 32: quantity * plain number
  zcalc.mul(zi.m("2.0"), "3.0"),
  // 33: plain number * quantity
  zcalc.mul("3.0", zi.m("2.0")),
  // 34: plain number * quantity * quantity
  zcalc.mul("3.0", zi.m("2.0"), zi.s("1.0")),
  // 35: units with uncertainty
  check(zcalc.mul(zi.m("2.0+-0.1"), zi.s("3.0+-0.1")), float: 6, uncertainty: 0.36055512754639896),
  // 36: convert-si: km * h
  check(zcalc.mul(zi.km("5"), zi.hour("2"), convert-si: true), float: 3.6e7),
  // 37: convert-si: g * (mol/g)
  check(zcalc.mul(zi.gram("10.0"), zi.declare("mol/g")("0.5"), convert-si: true), float: 5),
  // 38: convert-si: m * cm
  check(zcalc.mul(zi.m("2.0"), zi.cm("5.0"), convert-si: true), float: 0.1),
  // 39: convert-si: kg * g
  check(zcalc.mul(zi.kg("2.0"), zi.gram("5.0"), convert-si: true), float: 0.01),
  // 40: convert-si with call-site exponent
  check(zcalc.mul(zi.W("5.0"), zi.minute("30"), convert-si: true, exponent: "eng"), float: 9000),
  // 41: result of mul as input
  check(zcalc.mul(zcalc.mul("2.0", "3.0"), "4.00"), float: 24),
  // 42: mul of add
  check(zcalc.mul(zcalc.add("3", "4"), "5"), float: 35),
  // 43: mul of add with uncertainty
  check(zcalc.mul(zcalc.add("3+-0.3", "4+-0.4"), "5"), float: 35, uncertainty: 2.5),
  // 44: uncertainty on the second factor
  check(zcalc.mul("22", "2+-0.1"), float: 44, uncertainty: 2.2),
  // 45: keep full uncertainty digits
  check(zcalc.mul("22+-0.001234", "3", round: (follow-uncertainty: false)), float: 66),
  // 46: exponent notation in both factors
  check(zcalc.mul("1.5e3", "4.0e-2"), float: 60),
  // 47: integers
  check(zcalc.mul("22", "2"), float: 44),
  // 48: tiny numbers
  check(zcalc.mul("2.0e-3", "3.0e-4"), float: 6e-7),
  // 49: uncertainty with exponent
  check(zcalc.mul("5.00+-0.02e-1", "2.0e2"), float: 100, uncertainty: 0.4),
  // 50: trailing zeros count
  check(zcalc.mul("6.0", "7.00", "0.50"), float: 21),
  // 51: four factors with uncertainty
  check(zcalc.mul("2", "3.0+-0.1", "1.00", "5+-0.2"), float: 30, uncertainty: 1.5620499351813308),
  // 52: negative with uncertainty
  check(zcalc.mul("-5.0+-0.2", "3.0"), float: -15, uncertainty: 0.6),
  // 53: uncertainty digits decide the value digits
  check(zcalc.mul("7", "5+-0.1"), float: 35, uncertainty: 0.7),
  // 54: both factors uncertain
  check(zcalc.mul("7+-1", "5+-0.45"), float: 35, uncertainty: 5.909526207742885),
  // 55: two significant figures
  check(zcalc.mul("7.0", "5.0"), float: 35),
  // 56: big exponent notation
  check(zcalc.mul("3.4e3", "5.0e1"), float: 170000),
  // 57: 9.9 * 10.1
  zcalc.mul("9.9", "10.1"),
  // 58: 9.5 * 10.5
  zcalc.mul("9.5", "10.5"),
  // 59: m * m^-1
  zcalc.mul(zi.m("2.0"), zi.declare("m^-1")("3.0")),
  // 60: mul(0 +- 1, 5)
  check(zcalc.mul("0+-1", "5"), float: 0, uncertainty: 5),
  // 61: mul(5, 0 +- 1)
  check(zcalc.mul("5", "0+-1"), float: 0, uncertainty: 5),
  // 62: mul(0.0 +- 0.1, 3.0 +- 0.1)
  check(zcalc.mul("0.0+-0.1", "3.0+-0.1"), float: 0, uncertainty: 0.30000000000000004),
)
