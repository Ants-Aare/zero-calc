// stress test (compile only, see tests/stress): 200 chained operations mixed steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let k1=zimpl.operations.normalise-quantity("2.0")
#let k2=zimpl.operations.normalise-quantity("1.5")
#let k3=zimpl.operations.normalise-quantity("0.5")
#let step(x, _) = zimpl.operations.sub(zimpl.operations.mul((zimpl.operations.add((x, k1)), k2)), k3)
#zimpl.utility-display.display-info(range(200).fold(zimpl.operations.normalise-quantity("1.5+-0.1"), step))
