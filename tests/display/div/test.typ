#import "/src/lib.typ": *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)
#set-unit(fraction: "fraction")
#let m = zi.meter
#let s = zi.second

#let value = zcalc.div(m("55.12445+-2.345"), s("23.8+-0.1"))
// #let value = zcalc.mul(zcalc.add("2+-0.3", "4+-0.4"), "5+-1")
#value\
#display.variable(value, show-error: false)\
#display.variable(value, show-error: true)\
#display.method(value, show-error: false)\
#display.method-result(value, show-error: false)\
#display.method(value, show-error: true)\
#display.method-result(value, show-error: true)\

#display.error(value)\
#display.error-method(value)\
#display.error-method-result(value, block: true)
