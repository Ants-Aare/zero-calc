// display.error-method-result: `error calculation = error` as one equation.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  display.error-method-result(zcalc.add("1.5+-0.1", "2.5+-0.2")),
  // 2: mul
  display.error-method-result(zcalc.mul("2.0+-0.1", "3.0+-0.1")),
  // 3: quantity
  display.error-method-result(zcalc.div(zi.m("30+-0.3"), zi.s("5+-0.4"))),
)
