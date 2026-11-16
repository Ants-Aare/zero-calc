// stress test (compile only, see tests/stress): 200 independent mul results
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/src/impl.typ" as zimpl
#set page(width: auto, height: auto, margin: .5em)
#for i in range(200) [#zcalc.mul("1.5+-0.1", "2.0+-0.2")]
