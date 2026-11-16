// stress test (compile only, see tests/stress): 10 mul steps with preferred units set
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#zcalc.set-preferred-units(((match: zi.declare("kg m^2 s^-2"), preferred: zi.joule, exact-match: false),))
#let step(x, _) = zcalc.mul(x, zi.m("1.01+-0.01"))
#range(10).fold(zi.declare("kg m s^-2")("3.0+-0.1"), step)
