// stress test (compile only, see tests/stress): 100 chained zcalc mixed steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.sub(zcalc.mul(zcalc.add(x, "2.0"), "1.5"), "0.5")
#range(100).fold("1.5+-0.1", step)
