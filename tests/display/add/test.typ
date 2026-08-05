#import "/src/zero-calc.typ": *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter

#let values = range(1, 3).map(x => m(str(x / 7 * 3) + "+-1.23456", round: (
  precision: 3,
  mode: "places",
  uncertainty-precision: 1,
)))
#let value = zcalc.add(..values)

#display.variable(value, show-error: false)\
#display.variable(value, show-error: true)\
#display.method(value, show-error: false)\
#display.method-result(value, show-error: false)\
#display.method(value, show-error: true)\
#display.method-result(value, show-error: true)\

#display.error(value)\
#display.error-method(value)\
#display.error-method-result(value)\
