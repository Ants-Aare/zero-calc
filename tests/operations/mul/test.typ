#import "/src/lib.typ": *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)
// #let m = zi.meter.with(exponent: "eng")
// #let s = zi.second.with(exponent: "eng")
// #let g-mol = zi.declare("g/mol")
// #let mol = zi.mol
// #let g = zi.gram

// #calc.mul(2, 1)
// #calc.mul(2, 1, 0)
// #calc.mul(2, [3+-1])
// #calc.mul([2+-1], [3])
// #calc.mul([2+-1], [3+-2])\
// #calc.mul([2+-1], [3+-2], [4+-0.1])
// #calc.mul([2+-0.4], [1+-0.3])\
// #calc.mul(..range(1, 6).map(x => str(x) + "+-0.1"))


// #calc.mul([2+-1.1], [3+-1.2], [0+-0.1])

// #calc.mul(1000, "1e2")\
// #calc.mul(mol("1+-0.1"), g-mol("1+-0.1e3"), g(2))
// #calc.mul(m(2), 1)\
// #calc.mul(m("12e3"), s("22+-0.1"))
// #calc.mul(m("22+-0.1"), s("12e3"))\
// #let x = m("23+-.3e1")
// #let y = m("10+-0.4e2")
// #calc.mul(y, x)\
#let z = calc.mul([#std.calc.pi+-0.5678e2], (str(std.calc.e) + "+-0.1234"))
#z
#assert(impl.utility.retrieve-metadata(z).float == 853.9734222673567)
#assert(impl.utility.retrieve-metadata(z).uncertainty == 159.13825216056074)\
#let z = calc.mul(z, [1+-0.1])
#z
#assert(impl.utility.retrieve-metadata(z).float == 853.9734222673567)
#assert(impl.utility.retrieve-metadata(z).uncertainty == 180.6036803614711)\

