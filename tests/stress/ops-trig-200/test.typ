// stress test (compile only, see tests/stress): 200 chained operations trig steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let k=zimpl.operations.normalise-quantity("1.5")
#let step(x, _) = zimpl.operations.add((zimpl.operations.sin(x), k))
#zimpl.utility-display.display-info(range(200).fold(zimpl.operations.normalise-quantity("0.5+-0.01"), step))
