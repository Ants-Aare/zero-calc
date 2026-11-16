// stress test (compile only, see tests/stress): 100 chained operations units steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let k=zimpl.operations.normalise-quantity(zi.s("1.01+-0.01"))
#let k2=zimpl.operations.normalise-quantity(zi.s("1.00"))
#let step(x, _) = zimpl.operations.mul((zimpl.operations.div(x, k), k2))
#zimpl.utility-display.display-info(range(100).fold(zimpl.operations.normalise-quantity(zi.m("3.0+-0.1")), step))
