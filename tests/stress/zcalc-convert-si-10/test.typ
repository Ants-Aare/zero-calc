// stress test (compile only, see tests/stress): 10 chained adds with convert-si
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.add(x, zi.km("1.0"), convert-si: true)
#range(10).fold(zi.m("3.0+-0.1"), step)
