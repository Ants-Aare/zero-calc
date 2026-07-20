#import "../../src/lib.typ": *
#import "../../src/lib/zero/src/zero.typ": *

#set page(width: auto, height: auto, margin: 0.5em)

#let J = zi.declare("J")
#let J-mol = zi.declare("J/mol")
#let J-mol-K = zi.declare("J/mol/K")
#let Hz = zi.declare("1/s")
#let K = zi.K
#let m = zi.meter.with(exponent: "eng")
#let mol = zi.mol.with(exponent: "eng")
#let g = zi.gram.with(exponent: "eng")
#set-unit(fraction: "fraction")

// #let A = Hz("1.50e4")
// #let E-a = J-mol("50e3")
// #let R = J-mol-K("8.314")
// #let T = K("298")
#let temp-0C = K("273.15+-0.001")
#let temp-25K = K("25+-0.1")

#let room-temp = calc.add(temp-0C, temp-25K)
#calc.add(1000, "1e2")\
#calc.add(1, "1e3")\

// #num("1e0")
// #m("22+-9.1")\
// #calc.add(m("22+-0.1"))\ //, m("12e3"))\
// #let x = m("22e-2")
// #let y = m(10)
// #let y = m("8.123+-9.1e3")
// #x\
// #calc.add(x, y)\
// #calc.sub(y, x)\
// #calc.mul(m("22"), "2.0+-0.1e1")\
// #let x = calc.mul(m("22"), J-mol-K("20+-1"))
// #x\
// #calc.div(x, 5)\
// #calc.pow("10", "2+-0.1")\
// #calc.pow(m("10+-1"), 2)\
// #room-temp

// #calc.add(1,1)


// #let Ea = quantity(, "J/mol")
// #let R = quantity("8.314", "J/mol K")
// #let T = quantity("298", "K")
// Arrhenius equation is given by
// $ k = A e^(-E
// _
// a/(R T)) $
// This $k$, at $A = #A.display$, $E
// _
// a =
// #Ea.display$, and $T = #T.display$, we have
// #let k = {
// import calculation: *
// mul(A, exp(
// div(
// neg(Ea),
// mul(R, T)
// )
// ))
// }
// $
// k &= #k.method \
// &= #k.display
// $
