// zcalc.div: significant figures of the least precise operand, relative uncertainties in quadrature.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 6 / 3
  zcalc.div("6", "3"),
  // 2: 1 / 3 (1 sig fig)
  zcalc.div("1", "3"),
  // 3: 1.0 / 3 (limited by the divisor)
  zcalc.div("1.0", "3"),
  // 4: 1.00 / 3.000
  zcalc.div("1.00", "3.000"),
  // 5: negative dividend
  zcalc.div("-1.0", "3.0"),
  // 6: negative divisor
  zcalc.div("1.0", "-3.0"),
  // 7: negative / negative
  zcalc.div("-1.0", "-3.0"),
  // 8: zero dividend
  zcalc.div("0", "5"),
  // 9: 100 / 10 keeps trailing zeros as significant
  zcalc.div("100", "10"),
  // 10: exponents subtract
  zcalc.div("1e6", "1e3"),
  // 11: exponents subtract (negative)
  zcalc.div("1.5e3", "4.0e-2"),
  // 12: existing: 2.49 / 4.0
  zcalc.div("2.49", "4.0"),
  // 13: existing: 22 / 2
  zcalc.div("22", "2"),
  // 14: result above 100
  zcalc.div("5.0e2", "2.0"),
  // 15: float arguments
  zcalc.div(1.0, 4.0),
  // 16: constant divisor
  zcalc.div("5.00", zcalc.const("2")),
  // 17: pi divided by a number
  zcalc.div(zcalc.pi, "2.0"),
  // 18: README example without units
  check(zcalc.div("30+-0.3", "5+-0.4"), float: 6, uncertainty: 0.48373546489791297),
  // 19: uncertainty on the dividend only
  check(zcalc.div("22+-0.001234", "3"), float: 7.333333333333333, uncertainty: 0.0004113333333333333),
  // 20: uncertainty on the divisor only
  check(zcalc.div("1.0", "4+-0.1"), float: 0.25, uncertainty: 0.00625),
  // 21: negative quotient has a positive uncertainty
  check(zcalc.div("-6.0+-0.3", "3.0+-0.1"), float: -2, uncertainty: 0.1201850425154663),
  // 22: large uncertainty
  check(zcalc.div("123.456+-30", "2"), float: 61.728, uncertainty: 15),
  // 23: README example: m / s
  check(zcalc.div(zi.m("30+-0.3"), zi.s("5+-0.4")), float: 6, uncertainty: 0.48373546489791297),
  // 24: unit in the denominator
  zcalc.div("1.0", zi.s("4.0")),
  // 25: quantity / plain number
  zcalc.div(zi.m("1.0"), "4.0"),
  // 26: dividing by a compound unit
  zcalc.div(zi.m("1.0"), zi.declare("m/s")("4.0")),
  // 27: m / m^2
  zcalc.div(zi.m("6.0"), zi.declare("m^2")("3.0")),
  // 28: compound dividend
  zcalc.div(zi.declare("kg m")("6.0"), zi.s("3.0")),
  // 29: convert-si: km / h
  check(zcalc.div(zi.km("90"), zi.hour("1.5"), convert-si: true), float: 90000/5400),
  // 30: convert-si: g / mL
  check(zcalc.div(zi.gram("5.0"), zi.declare("mL")("2.0"), convert-si: true), float: 2500),
  // 31: quotient of quotients
  check(zcalc.div(zcalc.div("12.0", "3.0"), zcalc.div("4.0", "2.0")), float: 2),
  // 32: div of add
  check(zcalc.div(zcalc.add("3.5", "4.5"), "2.0"), float: 4),
  // 33: uncertainty on the divisor, 2 vs 1 sig fig
  check(zcalc.div("22", "2+-0.1"), float: 11, uncertainty: 0.55),
  // 34: exponent notation in the dividend
  check(zcalc.div("1.00e2", "3.0"), float: 100/3.0),
  // 35: tiny numbers
  check(zcalc.div("2.0e-3", "3.0e-4"), float: 20/3),
  // 36: uncertainty with exponent
  check(zcalc.div("5.00+-0.02e-1", "2.0e2"), float: 0.0025, uncertainty: 1e-5),
  // 37: negative dividend with uncertainty
  check(zcalc.div("-5.0+-0.2", "3.0"), float: -5/3, uncertainty: 0.2/3),
  // 38: quantities with uncertainty
  check(zcalc.div(zi.m("55.12445+-2.345"), zi.s("23.8+-0.1")), float: 2.3161533613445378, uncertainty: 0.09900884649405949),
)
