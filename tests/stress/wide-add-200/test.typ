// stress test (compile only, see tests/stress): one add with 200 terms
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#zcalc.add(..range(200).map(i => "1.25+-0.05"))
