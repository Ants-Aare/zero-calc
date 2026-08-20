#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.0": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter

#let values = range(3, 5).map(x => m(str(x / 7 * 3) + "+-0.56", round: (
  precision: 3,
  mode: "figures",
  uncertainty-precision: 2,
)))

#let value = zcalc.mul(..values)
// #let value = zcalc.mul(zcalc.add("2+-0.3", "4+-0.4"), "5+-1")

#display.variable(value, show-error: false)\
#display.variable(value, show-error: true)\
#display.method(value, show-error: false)\
#display.method-result(value, show-error: false)\
#display.method(value, show-error: true)\
#display.method-result(value, show-error: true)\

#display.error(value)\
#display.error-method(value)\
#display.error-method-result(value, block: true)\
