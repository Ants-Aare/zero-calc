// stress test (compile only, see tests/stress): 50 chained operations add steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let k=zimpl.operations.normalise-quantity("1.25+-0.05")
#let step(x, _) = zimpl.operations.add((x, k))
#zimpl.utility-display.display-info(range(50).fold(zimpl.operations.normalise-quantity("1.5+-0.1"), step))
