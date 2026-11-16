// stress test (compile only, see tests/stress): 50 chained convert-units round trips
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.convert-units(zcalc.convert-units(x, zi.km), zi.m)
#range(50).fold(zi.m("3.0+-0.1"), step)
