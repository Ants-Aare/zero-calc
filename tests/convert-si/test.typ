#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.0": *
#set page(width: auto, height: auto, margin: .5em)

#set-num(round: (precision: 2, mode: "figures"))
#set-unit(fraction: "fraction")


#zcalc.mul(zi.km-h(1), zi.second(50), convert-si: true)\
#display.method-result(zcalc.convert-units-to-si(zi.km-h("0.123")))

#display.method-result(zcalc.convert-units-to-si(zi.g-cm3("0.123")))
