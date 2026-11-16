// stress test (compile only, see tests/stress): variable/error of 20 nested add+mul steps
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let step(x, _) = zcalc.mul(zcalc.add(x, "2.0+-0.1"), "1.5+-0.1")
#let v = range(20).fold("1.5+-0.1", step)
#display.variable(v)
#display.error(v)
