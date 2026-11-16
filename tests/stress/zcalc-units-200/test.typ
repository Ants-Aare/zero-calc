// stress test (compile only, see tests/stress): 200 chained zcalc units steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.mul(zcalc.div(x, zi.s("1.01+-0.01")), zi.s("1.00"))
#range(200).fold(zi.m("3.0+-0.1"), step)
