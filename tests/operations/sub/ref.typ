// zcalc.sub: minuend minus one or more subtrahends.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)
#let me = zi.meter.with(exponent: "eng")

#cases(
  // 1: 5 - 3
  num("2"),
  // 2: 3 - 5
  num("-2"),
  // 3: 5 - 5
  num("0"),
  // 4: 5.0 - 5.0 keeps decimals
  num("0.0"),
  // 5: several subtrahends
  num("-4"),
  // 6: minuend only
  num("1"),
  // 7: negative minus negative
  num("-1"),
  // 8: subtracting a negative adds
  num("5.0"),
  // 9: loss of precision after cancellation
  num("0.00"),
  // 10: least precise decimal wins
  num("12.2"),
  // 11: float noise
  num("0.2"),
  // 12: order matters
  num("-3.0"),
  // 13: uncertainties still add in quadrature
  num("6.0+-0.5"),
  // 14: equal operands with uncertainty
  num("0+-1"),
  // 15: uncertainty on the subtrahend only
  num("4.0+-0.1"),
  // 16: uncertainty on the minuend only
  num("4.0+-0.1"),
  // 17: many subtrahends with uncertainty
  num("-2+-2"),
  // 18: same unit
  zi.m("0.25"),
  // 19: plain number after quantity inherits unit
  zi.m("1.0"),
  // 20: compound unit
  zi.declare("m/s")("3.0"),
  // 21: convert-si: celsius difference
  zi.K("15.0"),
  // 22: exact result of chained operations
  num("5.0"),
  // 23: of a subtraction
  num("2.0"),
  // 24: 2 - 1
  num("1"),
  // 25: 2 - (3 +- 1)
  num("-1+-1"),
  // 26: (2 +- 0.4) - (1 +- 0.3)
  num("1.0+-0.5"),
  // 27: 1000 - 1e2
  num("9.00e2"),
  // 28: 1 - 1e3
  num("-0.999e3"),
  // 29: eng exponent keeps the unit
  me("1"),
  // 30: eng: 12e3 - (22 +- 0.1)
  me("11.978+-0.0001e3"),
  // 31: eng: (22 +- 0.1) - 12e3
  me("-11.978+-0.0001e3"),
  // 32: eng: uncertainties on both
  me("7.7+-0.5e3"),
  // 33: pi - e with uncertainties
  num("0.4233+-0.1745"),
  // 34: ... minus a third uncertain term
  num("-0.6+-0.2"),
)
