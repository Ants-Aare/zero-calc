#import "/src/lib.typ": *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter.with(exponent: "eng")

#zcalc.add(1, "1e3")\
#zcalc.add("1e1", "1e2")\
#zcalc.add(1000, "10e1")\
#zcalc.add(1001, "10e1")\
#zcalc.add(1000, "1e2")\
#zcalc.add(1001, "1e2")\
#zcalc.add(1, "1e-1")\
#zcalc.add(1, "1e-2")\
#zcalc.add("1e-3", "1e-2")\
#zcalc.add("1.111e3", "1.1e3")\

#pagebreak()
#zcalc.add(2, 1)
#zcalc.add(2, [3+-1])
#zcalc.add([1+-0.4], [1+-0.3])\
#zcalc.add(..range(5).map(x => str(x) + "+-1.0"))
#zcalc.add(m(1), 1)\
#zcalc.add(m("22+-0.1"), m("12e3"))\

#pagebreak()
#zcalc.add("6e2", "6e2")
#zcalc.add("6.11+-0.111", "6.22")\
#zcalc.add("6.11+-0.111e2", "6.22e2")\
#zcalc.add("6.11+-0.111", "6.22e2")\
#zcalc.add("6.11+-0.1e3", "622.123")\
#zcalc.add("6.11+-0.111e2", "6.222222+-0.11e2")\
#zcalc.add("6.11111e2", "6.2222222222e3")\
#zcalc.add("6.11111e2", "62.222222222e2")\

#pagebreak()
#let z = zcalc.add([#calc.pi+-0.1234], str(calc.e) + "+-0.1234")
#z\
#assert(impl.utility.retrieve-metadata(z).float == calc.pi + calc.e)
#assert(impl.utility.retrieve-metadata(z).uncertainty == 0.17451395359683994)
#let z = zcalc.add(z, [1+-0.1])
#z
#assert(impl.utility.retrieve-metadata(z).float == calc.pi + calc.e + 1)
#assert(impl.utility.retrieve-metadata(z).uncertainty == 0.2011345818102894)

#pagebreak()
#zcalc.mul(zcalc.add("3", "4"), "5")\
#zcalc.mul(zcalc.add("3", "4"), "5+-0.1")\
#zcalc.mul(zcalc.add("3.0", "4.0"), "5.0")\
#zcalc.mul(zcalc.add("3", "4.0"), "5.0")\
#zcalc.mul(zcalc.add("3+-0.3", "4+-0.4"), "5")\
#zcalc.mul(zcalc.add("3+-0.7", "4+-0.7"), "5+-0.45")\
#zcalc.mul(zcalc.add("3e3", "4e2"), "5.0e1")\
#pagebreak()

#zcalc.add(zcalc.mul("3", "4"), "5")\
#zcalc.add(zcalc.mul("3", "4"), "5+-0.1")\
// #zcalc.mul("3+-0.3", "4+-0.4")\
// #zcalc.mul("3", "4")
// #zcalc.mul("3.0", "4.0")
// #zcalc.mul("3", "4.0")
// #zcalc.mul("3+-1", "4+-1")
// #zcalc.mul("3e3", "4e2")
#zcalc.add(zcalc.mul("3.0", "4.0"), "5.0")\
#zcalc.add(zcalc.mul("3", "4.0"), "5.0")\
#zcalc.add(zcalc.mul("3+-0.3", "4+-0.4"), "5")\
#zcalc.add(zcalc.mul("3+-1", "4+-1"), "5+-0.99")\
#zcalc.add(zcalc.mul("3e3", "4e2"), "5.0e1")\

