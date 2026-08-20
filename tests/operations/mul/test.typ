#import "/src/zero-calc.typ": *
#import impl.utility: *
#import "@preview/zero:0.7.0": *
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
// #calc.#x\mul(y, x)\
// #let z = calc.mul([#std.calc.pi+-0.5678e2], (str(std.calc.e) + "+-0.1234"))
// #z
// #assert(impl.utility.retrieve-metadata(z).float == 853.9734222673567)
// #assert(impl.utility.retrieve-metadata(z).uncertainty == 159.13825216056074)\
// #let z = calc.mul(z, [1+-0.1])
// #z
// #assert(impl.utility.retrieve-metadata(z).float == 853.9734222673567)
// #assert(impl.utility.retrieve-metadata(z).uncertainty == 180.6036803614711)\
//
//

#let x = zcalc.mul("22", "2+-0.1")
#assert(retrieve-metadata(x).float == 44)
#x\
#let x = zcalc.mul("22+-0.001234", "3", round: (follow-uncertainty: false))
#assert(retrieve-metadata(x).float == 66)
#x\
#let x = zcalc.mul("123.456+-30", "2")
#assert(retrieve-metadata(x).float == 246.912)
#x
#let x = zcalc.mul("2.49", "4.0")
#assert(retrieve-metadata(x).float == 9.96)
#x\
#let x = zcalc.mul("1.5e3", "4.0e-2")
#assert(retrieve-metadata(x).float == 60)
#x
#let x = zcalc.mul("1.00e2", "3.0")
#assert(retrieve-metadata(x).float == 300)
#x\
#let x = zcalc.mul("22", "2")
#assert(retrieve-metadata(x).float == 44)
#x
#let x = zcalc.mul("2.0e-3", "3.0e-4")
#assert(retrieve-metadata(x).float == 0.0000006)
#x\
#let x = zcalc.mul("5.00+-0.02e-1", "2.0e2")
#assert(retrieve-metadata(x).float == 100)
#x\
#let x = zcalc.mul("2.0+-0.1", "3.00+-0.05", "1.5")
#assert(retrieve-metadata(x).float == 9.0)
#x
#let x = zcalc.mul("6.0", "7.00", "0.50")
#assert(retrieve-metadata(x).float == 21.0)
#x\
#let x = zcalc.mul("2", "3.0+-0.1", "1.00", "5+-0.2")
#assert(retrieve-metadata(x).float == 30.0)
#x
#let x = zcalc.mul("-5.0+-0.2", "3.0")
#assert(retrieve-metadata(x).float == -15.0)
#x\
