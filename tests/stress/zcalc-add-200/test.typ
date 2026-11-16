// stress test (compile only, see tests/stress): 200 chained zcalc add steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.add(x, "1.25+-0.05")
#range(200).fold("1.5+-0.1", step)
