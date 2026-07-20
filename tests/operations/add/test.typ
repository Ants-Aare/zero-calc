#import "/src/lib.typ": *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter.with(exponent: "eng")

#calc.add(2, 1)
#calc.add(2, [3+-1])
#calc.add([1+-0.4], [1+-0.3])\
#calc.add(..range(5).map(x => str(x) + "+-1"))
#calc.add(1000, "1e2")\
#calc.add(1, "1e3")
#calc.add(m(1), 1)\
#calc.add(m("22+-0.1"), m("12e3"))\
#let x = m("23+-3e2")
#let y = m("10+-0.4e3")
#calc.add(x, y)\
#let z = calc.add([#std.calc.pi+-0.1234], str(std.calc.e) + "+-0.1234")
#z
#assert(impl.utility.retrieve-metadata(z).float == std.calc.pi + std.calc.e)
#assert(impl.utility.retrieve-metadata(z).uncertainty == 0.17451395359683994)\
#let z = calc.add(z, [1+-0.1])
#z
#assert(impl.utility.retrieve-metadata(z).float == std.calc.pi + std.calc.e + 1)
#assert(impl.utility.retrieve-metadata(z).uncertainty == 0.2011345818102894)\

