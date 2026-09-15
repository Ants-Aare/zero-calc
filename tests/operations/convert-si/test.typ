#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.0": *
#import "@preview/zero-calc:0.7.0"
#set page(width: auto, height: auto, margin: .5em)

// #set-num(round: (precision: 2, mode: "figures"))
#set-unit(fraction: "fraction")


#display.method-result(zcalc.convert-units-to-si(zi.declare("cm^-2")(15)))\
#display.method-result(zcalc.convert-units-to-si(zi.declare("cd")(15)))
#display.method-result(zcalc.convert-units-to-si(zi.declare("kg")(15)))\
#display.method-result(zcalc.convert-units-to-si(zi.declare("mg")(15)))\
#display.method-result(zcalc.convert-units-to-si(zi.declare("cm")(15)))\
#display.method-result(zcalc.convert-units-to-si(zi.declare("cm^3")(15)))\
#display.method-result(zcalc.convert-units-to-si(zi.declare("mm")("1239+-0.1")))\

#pagebreak()

#display.method-result(zcalc.convert-units-to-si(zi.km-h("3.6")))\
#display.method-result(zcalc.convert-units-to-si(zi.minute("2.0")))\
#display.method-result(zcalc.convert-units-to-si(zi.Hz(2)))
#display.method-result(zcalc.convert-units-to-si(zi.declare("1/h")(2)))\
#display.method-result(zcalc.convert-units-to-si(zi.declare("1/h^2")(2)))\
#display.method-result(zcalc.convert-units-to-si(zi.J(5123, exponent: "eng")))\
#display.method-result(zcalc.mul(zi.km-h(5), zi.minute(30), convert-si: true))\
#display.method-result(zcalc.convert-units-to-si(zi.km-h("0.123")))\

// #zero-calc.impl.operations.const(
//   (
//     float: 10000,
//     info: (int: "1", frac: "", sign: "+", pm: none, e: "4"),
//     unit: none,
//     args: arguments(omit-unity-mantissa: true),
//   ),
// )
// #display.method-result(zcalc.convert-units-to-si(zi.liter(15)))\

// #display.method-result(zcalc.convert-units-to-si(zi.g-cm3("0.123")))
