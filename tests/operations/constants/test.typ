// zcalc.pi / e / tau / inf / const: constants keep all digits and never limit the precision of results.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: pi
  zcalc.pi,
  // 2: e
  zcalc.e,
  // 3: tau
  zcalc.tau,
  // 4: inf
  zcalc.inf,
  // 5: const from a string
  zcalc.const("3"),
  // 6: const keeps decimals
  zcalc.const("3.0"),
  // 7: const from a float
  zcalc.const(0.1),
  // 8: const from a num()
  zcalc.const(num("6.022e+23")),
  // 9: const + const
  zcalc.add(zcalc.const("3.0"), zcalc.const("4")),
  // 10: const + measured: decimals of the measured value
  zcalc.add(zcalc.const("3.0"), "4.55"),
  // 11: const * measured: sig figs of the measured value
  check(zcalc.mul(zcalc.const("3.0"), "4.55"), float: 13.65),
  // 12: const * const
  zcalc.mul(zcalc.const("0.1"), zcalc.const("3")),
  // 13: const / measured
  zcalc.div(zcalc.const("1"), "4.0"),
  // 14: pi * integer
  check(zcalc.mul(zcalc.pi, "2"), float: 2*calc.pi),
  // 15: pi * decimal
  check(zcalc.mul(zcalc.pi, "2.0"), float: 2*calc.pi),
  // 16: circle circumference
  check(zcalc.mul("2", zcalc.pi, "1.50"), float: 3*calc.pi),
  // 17: circle area
  check(zcalc.mul(zcalc.pi, zcalc.pow("1.50", "2")), float: calc.pi*2.25),
  // 18: pi / pi
  check(zcalc.div(zcalc.pi, zcalc.pi), float: 1),
  // 19: tau / 2
  check(zcalc.div(zcalc.tau, "2"), float: calc.pi),
  // 20: tau / 2 (constant)
  zcalc.div(zcalc.tau, zcalc.const("2")),
  // 21: pi + pi
  check(zcalc.add(zcalc.pi, zcalc.pi), float: 2*calc.pi),
  // 22: e squared
  check(zcalc.pow(zcalc.e, "2"), float: calc.pow(calc.e, 2)),
  // 23: ln(e) = 1
  check(zcalc.ln(zcalc.e), float: 1),
  // 24: sqrt(pi)
  check(zcalc.sqrt(zcalc.pi), float: calc.sqrt(calc.pi)),
  // 25: sin(pi/6) with a constant divisor
  check(zcalc.sin(zcalc.div(zcalc.pi, zcalc.const("6"))), float: 0.5),
  // 26: avogadro (from the README)
  check(zcalc.mul(zcalc.const(num("6.022e+23")), "2.0"), float: 1.2044e24),
  // 27: mul of constants stays constant
  check(zcalc.mul(zcalc.mul(zcalc.const("0.1"), zcalc.const("3")), "2.00"), float: 0.6),
  // 28: add of constants stays constant
  check(zcalc.add(zcalc.add(zcalc.const("1.5"), zcalc.const("2.5")), "1.25"), float: 5.25),
  // 29: div of constants stays constant
  check(zcalc.mul(zcalc.div(zcalc.const("1"), zcalc.const("8")), "4.00"), float: 0.5),
  // 30: pow of constants stays constant
  check(zcalc.mul(zcalc.pow(zcalc.const("2"), "3"), "2.00"), float: 16),
  // 31: sqrt of a constant stays constant
  check(zcalc.mul(zcalc.sqrt(zcalc.const("4")), "2.00"), float: 4),
  // 32: log of constants stays constant
  check(zcalc.mul(zcalc.log(zcalc.const("100"), zcalc.const("10")), "3.00"), float: 6),
  // 33: neg of a constant stays constant
  check(zcalc.mul(zcalc.neg(zcalc.const("2")), "3.00"), float: -6),
  // 34: abs of a constant stays constant
  check(zcalc.mul(zcalc.abs(zcalc.const("-2")), "3.00"), float: 6),
  // 35: sin of a constant stays constant
  check(zcalc.mul(zcalc.sin(zcalc.const("0.5")), "2.00"), float: 0.9588510772084060),
  // 36: abs of constant
  zcalc.abs(zcalc.pi),
)
