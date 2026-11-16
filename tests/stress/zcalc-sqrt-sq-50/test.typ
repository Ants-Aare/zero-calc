// stress test (compile only, see tests/stress): 50 chained zcalc sqrt-sq steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.pow(zcalc.sqrt(x), "2")
#range(50).fold("2.5+-0.1", step)
