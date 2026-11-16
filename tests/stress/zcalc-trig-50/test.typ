// stress test (compile only, see tests/stress): 50 chained zcalc trig steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.add(zcalc.sin(x), "1.5")
#range(50).fold("0.5+-0.01", step)
