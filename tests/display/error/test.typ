// display.error: the uncertainty of a value on its own.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: uncertainty of a sum
  display.error(zcalc.add("1.5+-0.1", "2.5+-0.1")),
  // 2: uncertainty with unit
  display.error(zcalc.mul(zi.m("2.0+-0.1"), zi.s("3.0+-0.1"))),
  // 3: no uncertainty is zero
  display.error(zcalc.add("1.5", "2.5")),
  // 4: uncertainty of an input keeps its digits
  display.error(num("1.5+-0.123")),
  // 5: uncertainty in exponent notation
  display.error(zcalc.mul("5.00+-0.02e-1", "2.0e2")),
)
