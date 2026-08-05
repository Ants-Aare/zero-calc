#import "/src/zero-calc.typ": *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter.with(exponent: "eng")

#zcalc.sub(2, 1)
#zcalc.sub(2, [3+-1])
#zcalc.sub([2+-0.4], [1+-0.3])\
#zcalc.sub(..range(5).map(x => str(x) + "+-1").rev())
#zcalc.sub(1000, "1e2")\
#zcalc.sub(1, "1e3")
#zcalc.sub(m(2), 1)\
#zcalc.sub(m("12e3"), m("22+-0.1"))\
#zcalc.sub(m("22+-0.1"), m("12e3"))\
#let x = m("23+-3e2")
#let y = m("10+-0.4e3")
#zcalc.sub(y, x)\
#let z = zcalc.sub([#calc.pi+-0.1234], str(calc.e) + "+-0.1234")
#z
#assert(impl.utility.retrieve-metadata(z).float == (calc.pi - calc.e))
#assert(impl.utility.retrieve-metadata(z).uncertainty == 0.17451395359683994)\
#let z = zcalc.sub(z, [1+-0.1])
#z
#assert(impl.utility.retrieve-metadata(z).float == calc.pi - calc.e - 1)
#assert(impl.utility.retrieve-metadata(z).uncertainty == 0.2011345818102894)\

