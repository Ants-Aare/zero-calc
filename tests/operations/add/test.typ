// zcalc.add: plain numbers, uncertainties, units and exponents.
// Additions round to the least precise *decimal place*.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)
#let me = zi.meter.with(exponent: "eng")

#cases(
  // 1: integers
  zcalc.add("1", "1"),
  // 2: binary float noise 0.1 + 0.2
  zcalc.add("0.1", "0.2"),
  // 3: tie rounds away from zero (1.25)
  zcalc.add("1.0", "0.25"),
  // 4: least precise operand limits decimals
  zcalc.add("100", "0.5"),
  // 5: cancels to zero
  zcalc.add("-5", "5"),
  // 6: cancels to zero keeps decimals
  zcalc.add("-5.0", "5.0"),
  // 7: zero + zero
  zcalc.add("0", "0"),
  // 8: single summand is returned as is
  zcalc.add("3.14"),
  // 9: single summand with uncertainty
  zcalc.add("1.5+-0.1"),
  // 10: carry into a new digit 9.9 + 0.1
  zcalc.add("9.9", "0.1"),
  // 11: carry into a new digit 99.9 + 0.1
  zcalc.add("99.9", "0.1"),
  // 12: carry into a new digit 999 + 1
  zcalc.add("999", "1"),
  // 13: many summands
  zcalc.add("1.5", "2.25", "3.125", "0.5"),
  // 14: all negative
  zcalc.add("-1.5", "-2.5"),
  // 15: int and float arguments
  zcalc.add(5, 2.5),
  // 16: float arguments
  zcalc.add(0.1, 0.2),
  // 17: content arguments
  zcalc.add([1.5+-0.1], [2.5+-0.1]),
  // 18: num() arguments
  zcalc.add(num("1.5"), num("2.25")),
  // 19: leading decimal point
  zcalc.add(".5", ".25"),
  // 20: trailing decimal point
  zcalc.add("5.", "2.5"),
  // 21: leading zeros
  zcalc.add("007", "1"),
  // 22: explicit plus sign
  zcalc.add("+1.5", "2.5"),
  // 23: unicode minus sign
  zcalc.add("−1.5", "2.5"),
  // 24: comma as decimal separator
  zcalc.add("1,5", "2,5"),
  // 25: capital E exponent
  zcalc.add("1E3", "1E3"),
  // 26: same exponent
  zcalc.add("2.5e3", "1.5e3"),
  // 27: same negative exponent
  zcalc.add("2.5e-3", "1.5e-3"),
  // 28: 1e3 + 1e3
  zcalc.add("1e3", "1e3"),
  // 29: 1e-5 + 2e-5
  zcalc.add("1e-5", "2e-5"),
  // 30: mixed exponents keep integer digits
  zcalc.add("2.5e3", "500"),
  // 31: large float
  zcalc.add(1e21, 1e21),
  // 32: uncertainties add in quadrature
  check(zcalc.add("1+-0.3", "2+-0.4"), float: 3, uncertainty: 0.5),
  // 33: quadrature, larger numbers
  check(zcalc.add("10.0+-0.3", "20.0+-0.4"), float: 30, uncertainty: 0.5),
  // 34: one operand without uncertainty is exact
  zcalc.add(2, [3+-1]),
  // 35: negative values with uncertainty
  check(zcalc.add("-1.0+-0.1", "-2.0+-0.2"), float: -3, uncertainty: 0.223606797749979),
  // 36: uncertainty larger than the value
  zcalc.add("0+-0.1", "0+-0.1"),
  // 37: five operands
  check(zcalc.add(..range(5).map(x => str(x) + "+-1.0")), float: 10, uncertainty: 2.23606797749979),
  // 38: parenthesis uncertainty notation
  zcalc.add("1.50(10)", "1"),
  // 39: uncertainty with exponent
  zcalc.add("1.5+-0.1e2", "1"),
  // 40: uncertainty sets the rounding place
  zcalc.add("6.11+-0.111", "6.22"),
  // 41: same unit
  zcalc.add(zi.m("1.0"), zi.m("2.0")),
  // 42: plain number after a quantity inherits its unit
  zcalc.add(zi.m("1.0"), "2.0"),
  // 43: unit with uncertainty
  zcalc.add(zi.m("1.0+-0.1"), zi.m("2.0+-0.1")),
  // 44: compound unit
  zcalc.add(zi.declare("m/s")("1.5"), zi.declare("m/s")("2.5")),
  // 45: same unit in different order
  zcalc.add(zi.declare("L/mol")("1.0"), zi.declare("mol^-1 L")("2.0")),
  // 46: unit exponent order
  zcalc.add(zi.declare("m s")("1.0"), zi.declare("s m")("2.0")),
  // 47: convert-si: m + mm
  zcalc.add(zi.m("1.000"), zi.mm("5.0"), convert-si: true),
  // 48: convert-si: h + min
  zcalc.add(zi.hour("1.0"), zi.minute("30.0"), convert-si: true),
  // 49: result of add as input
  check(zcalc.add(zcalc.add("1.5", "2.5"), "1.25"), float: 5.25),
  // 50: result of add keeps uncertainty
  check(zcalc.add(zcalc.add("1.5+-0.3", "2.5+-0.4"), "1.25+-0.12"), float: 5.25, uncertainty: 0.5141984052872977),
  // 51: 1000 + 10e1
  zcalc.add(1000, "10e1"),
  // 52: 1001 + 10e1
  zcalc.add(1001, "10e1"),
  // 53: 1001 + 1e2
  zcalc.add(1001, "1e2"),
  // 54: 1.111e3 + 1.1e3
  zcalc.add("1.111e3", "1.1e3"),
  // 55: uncertainties and exponents
  zcalc.add("6.11+-0.111e2", "6.22e2"),
  // 56: uncertainty and exponent on one side
  zcalc.add("6.11+-0.111", "6.22e2"),
  // 57: uncertainty larger than the other operand
  zcalc.add("6.11+-0.1e3", "622.123"),
  // 58: two uncertainties with exponents
  zcalc.add("6.11+-0.111e2", "6.222222+-0.11e2"),
  // 59: many digits, exponent 3 + 2
  zcalc.add("6.11111e2", "6.2222222222e3"),
  // 60: many digits, same value other exponent
  zcalc.add("6.11111e2", "62.222222222e2"),
  // 61: eng exponent keeps the unit
  zcalc.add(me("22+-0.1"), me("12e3")),
  // 62: eng exponent of a single quantity
  zcalc.add(me(1), 1),
  // 63: pi + e with uncertainties
  check(zcalc.add([#calc.pi+-0.1234], str(calc.e) + "+-0.1234"), float: calc.pi + calc.e, uncertainty: 0.17451395359683994),
  // 64: ... plus a third uncertain term
  check(zcalc.add(zcalc.add([#calc.pi+-0.1234], str(calc.e) + "+-0.1234"), [1+-0.1]), float: calc.pi + calc.e + 1, uncertainty: 0.2011345818102894),
)
