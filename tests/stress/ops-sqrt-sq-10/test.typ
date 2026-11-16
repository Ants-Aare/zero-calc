// stress test (compile only, see tests/stress): 10 chained operations sqrt-sq steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let k=zimpl.operations.normalise-quantity("2")
#let step(x, _) = zimpl.operations.pow(zimpl.operations.sqrt(x), k)
#zimpl.utility-display.display-info(range(10).fold(zimpl.operations.normalise-quantity("2.5+-0.1"), step))
