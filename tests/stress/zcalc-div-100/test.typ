// stress test (compile only, see tests/stress): 100 chained zcalc div steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.div(x, "1.01+-0.01")
#range(100).fold("1.5+-0.1", step)
