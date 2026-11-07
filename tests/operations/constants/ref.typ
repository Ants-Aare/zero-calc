// zcalc.pi / e / tau / inf / const: constants keep all digits and never limit the precision of results.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: pi
  num(calc.pi),
  // 2: e
  num(calc.e),
  // 3: tau
  num(calc.tau),
  // 4: inf
  num(calc.inf),
  // 5: const from a string
  num("3"),
  // 6: const keeps decimals
  num("3.0"),
  // 7: const from a float
  num("0.1"),
  // 8: const from a num()
  num("6.022e+23"),
  // 9: const + const
  num("7"),
  // 10: const + measured: decimals of the measured value
  num("7.55"),
  // 11: const * measured: sig figs of the measured value
  num("13.7"),
  // 12: const * const
  num("3e-1"),
  // 13: const / measured
  num("2.5e-1"),
  // 14: pi * integer
  num("6"),
  // 15: pi * decimal
  num("6.3"),
  // 16: circle circumference
  num("9"),
  // 17: circle area
  num("7.07"),
  // 18: pi / pi
  num("1"),
  // 19: tau / 2
  num("3"),
  // 20: tau / 2 (constant)
  num("3.1415926535898"),
  // 21: pi + pi
  num("6.2831853071796"),
  // 22: e squared
  num("7.3890560989307"),
  // 23: ln(e) = 1
  num("1"),
  // 24: sqrt(pi)
  num("1.7724538509055"),
  // 25: sin(pi/6) with a constant divisor
  num("0.5"),
  // 26: avogadro (from the README)
  num("1.2e24"),
  // 27: mul of constants stays constant
  num("6.00e-1"),
  // 28: add of constants stays constant
  num("5.25"),
  // 29: div of constants stays constant
  num("5.00e-1"),
  // 30: pow of constants stays constant
  num("16.0"),
  // 31: sqrt of a constant stays constant
  num("4.00"),
  // 32: log of constants stays constant
  num("6.00"),
  // 33: neg of a constant stays constant
  num("-6.00"),
  // 34: abs of a constant stays constant
  num("6.00"),
  // 35: sin of a constant stays constant
  num("9.59e-1"),
  // 36: abs of constant
  num(calc.pi),
)
