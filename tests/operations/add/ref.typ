// zcalc.add: plain numbers, uncertainties, units and exponents.
// Additions round to the least precise *decimal place*.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)
#let me = zi.meter.with(exponent: "eng")

#cases(
  // 1: integers
  num("2"),
  // 2: binary float noise 0.1 + 0.2
  num("0.3"),
  // 3: tie rounds away from zero (1.25)
  num("1.3"),
  // 4: least precise operand limits decimals
  num("101"),
  // 5: cancels to zero
  num("0"),
  // 6: cancels to zero keeps decimals
  num("0.0"),
  // 7: zero + zero
  num("0"),
  // 8: single summand is returned as is
  num("3.14"),
  // 9: single summand with uncertainty
  num("1.5+-0.1"),
  // 10: carry into a new digit 9.9 + 0.1
  num("10.0"),
  // 11: carry into a new digit 99.9 + 0.1
  num("100.0"),
  // 12: carry into a new digit 999 + 1
  num("1000"),
  // 13: many summands
  num("7.4"),
  // 14: all negative
  num("-4.0"),
  // 15: int and float arguments
  num("8"),
  // 16: float arguments
  num("0.3"),
  // 17: content arguments
  num("4.0+-0.1"),
  // 18: num() arguments
  num("3.8"),
  // 19: leading decimal point
  num("0.8"),
  // 20: trailing decimal point
  num("8"),
  // 21: leading zeros
  num("8"),
  // 22: explicit plus sign
  num("4.0"),
  // 23: unicode minus sign
  num("1.0"),
  // 24: comma as decimal separator
  num("4.0"),
  // 25: capital E exponent
  num("2E3"),
  // 26: same exponent
  num("4.0e3"),
  // 27: same negative exponent
  num("4.0e-3"),
  // 28: 1e3 + 1e3
  num("2e3"),
  // 29: 1e-5 + 2e-5
  num("3e-5"),
  // 30: mixed exponents keep integer digits
  num("3.000e3"),
  // 31: large float
  num("2000000000000000000000"),
  // 32: uncertainties add in quadrature
  num("3.0+-0.5"),
  // 33: quadrature, larger numbers
  num("30.0+-0.5"),
  // 34: one operand without uncertainty is exact
  num("5+-1"),
  // 35: negative values with uncertainty
  num("-3.0+-0.2"),
  // 36: uncertainty larger than the value
  num("0.0+-0.1"),
  // 37: five operands
  num("10.0+-2.2"),
  // 38: parenthesis uncertainty notation
  num("2.50+-0.10"),
  // 39: uncertainty with exponent
  num("1.5+-0.1e2"),
  // 40: uncertainty sets the rounding place
  num("12.33+-0.111"),
  // 41: same unit
  zi.m("3.0"),
  // 42: plain number after a quantity inherits its unit
  zi.m("3.0"),
  // 43: unit with uncertainty
  zi.m("3.0+-0.1"),
  // 44: compound unit
  zi.declare("m/s")("4.0"),
  // 45: same unit in different order
  zi.declare("L/mol")("3.0"),
  // 46: unit exponent order
  zi.declare("m s")("3.0"),
  // 47: convert-si: m + mm
  zi.m("1.005"),
  // 48: convert-si: h + min
  zi.s("5.4e3"),
  // 49: exponent of the first operand is used
  zi.m("3.0", exponent: "sci"),
  // 50: call-site named argument
  num("3.0", exponent: "sci"),
  // 51: call-site round
  num("3.6"),
  // 52: result of add as input
  num("5.3"),
  // 53: result of add keeps uncertainty
  num("5.3+-0.5"),
  // 54: 1000 + 10e1
  num("110.0e1"),
  // 55: 1001 + 10e1
  num("110.1e1"),
  // 56: 1001 + 1e2
  num("11.01e2"),
  // 57: 1.111e3 + 1.1e3
  num("2.2e3"),
  // 58: uncertainties and exponents
  num("12.33+-0.111e2"),
  // 59: uncertainty and exponent on one side
  num("6.2811+-0.00111e2"),
  // 60: uncertainty larger than the other operand
  num("6.7+-0.1e3"),
  // 61: two uncertainties with exponents
  num("12.33+-0.16e2"),
  // 62: many digits, exponent 3 + 2
  num("6.833333e3"),
  // 63: many digits, same value other exponent
  num("68.33333e2"),
  // 64: eng exponent keeps the unit
  me("12.022+-0.0001e3"),
  // 65: eng exponent of a single quantity
  me("2"),
  // 66: pi + e with uncertainties
  num[#(calc.pi + calc.e)+-0.1745],
  // 67: ... plus a third uncertain term
  num[#(calc.pi + calc.e + 1)+-0.2],
)
