// stress test (compile only, see tests/stress): error-method of a chain of 100 products, one product after merging
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#set page(width: auto, height: auto, margin: .5em)
#display.error-method(range(100).fold("1.0", (x, _) => zcalc.mul(x, "1.01+-0.01")))
