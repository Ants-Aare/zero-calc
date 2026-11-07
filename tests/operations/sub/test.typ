// zcalc.sub: minuend minus one or more subtrahends.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)
#let me = zi.meter.with(exponent: "eng")

#cases(
  // 1: 5 - 3
  zcalc.sub("5", "3"),
  // 2: 3 - 5
  zcalc.sub("3", "5"),
  // 3: 5 - 5
  zcalc.sub("5", "5"),
  // 4: 5.0 - 5.0 keeps decimals
  zcalc.sub("5.0", "5.0"),
  // 5: several subtrahends
  zcalc.sub("1", "2", "3"),
  // 6: minuend only
  zcalc.sub("1"),
  // 7: negative minus negative
  zcalc.sub("-3", "-2"),
  // 8: subtracting a negative adds
  zcalc.sub("3.0", "-2.0"),
  // 9: loss of precision after cancellation
  check(zcalc.sub("1.00", "0.999"), float: 0.001),
  // 10: least precise decimal wins
  zcalc.sub("12.345", "0.1"),
  // 11: float noise
  zcalc.sub(0.3, 0.1),
  // 12: order matters
  zcalc.sub("2.0", "5.0"),
  // 13: uncertainties still add in quadrature
  check(zcalc.sub("10+-0.3", "4+-0.4"), float: 6, uncertainty: 0.5),
  // 14: equal operands with uncertainty
  check(zcalc.sub("-5+-1", "-5+-1"), float: 0, uncertainty: 1.4142135623730951),
  // 15: uncertainty on the subtrahend only
  zcalc.sub("5.0", "1.0+-0.1"),
  // 16: uncertainty on the minuend only
  zcalc.sub("5.0+-0.1", "1.0"),
  // 17: many subtrahends with uncertainty
  check(zcalc.sub(..range(5).map(x => str(x) + "+-1").rev()), float: -2, uncertainty: 2.23606797749979),
  // 18: same unit
  zcalc.sub(zi.m("0.50"), zi.m("0.25")),
  // 19: plain number after quantity inherits unit
  zcalc.sub(zi.m("2.0"), "1.0"),
  // 20: compound unit
  zcalc.sub(zi.declare("m/s")("5.5"), zi.declare("m/s")("2.5")),
  // 21: convert-si: celsius difference
  zcalc.sub(zi.degreeCelsius("20.0"), zi.degreeCelsius("5.0"), convert-si: true),
  // 22: exact result of chained operations
  zcalc.sub(zcalc.add("5.5", "1.5"), "2.0"),
  // 23: of a subtraction
  zcalc.sub(zcalc.sub("5.5", "1.5"), "2.0"),
  // 24: 2 - 1
  zcalc.sub(2, 1),
  // 25: 2 - (3 +- 1)
  zcalc.sub(2, [3+-1]),
  // 26: (2 +- 0.4) - (1 +- 0.3)
  zcalc.sub([2+-0.4], [1+-0.3]),
  // 27: 1000 - 1e2
  zcalc.sub(1000, "1e2"),
  // 28: 1 - 1e3
  zcalc.sub(1, "1e3"),
  // 29: eng exponent keeps the unit
  zcalc.sub(me(2), 1),
  // 30: eng: 12e3 - (22 +- 0.1)
  zcalc.sub(me("12e3"), me("22+-0.1")),
  // 31: eng: (22 +- 0.1) - 12e3
  zcalc.sub(me("22+-0.1"), me("12e3")),
  // 32: eng: uncertainties on both
  zcalc.sub(me("10+-0.4e3"), me("23+-3e2")),
  // 33: pi - e with uncertainties
  check(zcalc.sub([#calc.pi+-0.1234], str(calc.e) + "+-0.1234"), float: calc.pi - calc.e, uncertainty: 0.17451395359683994),
  // 34: ... minus a third uncertain term
  check(zcalc.sub(zcalc.sub([#calc.pi+-0.1234], str(calc.e) + "+-0.1234"), [1+-0.1]), float: calc.pi - calc.e - 1, uncertainty: 0.2011345818102894),
)
