// stress test (compile only, see tests/stress): 200 evaluations of an equation
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#let f = equation.define($ a dot b + c / d $)
#for i in range(200) [#f(a: "1.5+-0.1", b: "2.0", c: "3.0+-0.2", d: "4.0")]
