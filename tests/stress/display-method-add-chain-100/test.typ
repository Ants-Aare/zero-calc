// stress test (compile only, see tests/stress): method of a chain of 100 additions, one sum after merging
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#set page(width: auto, height: auto, margin: .5em)
#display.method(range(100).fold("1.0", (x, _) => zcalc.add(x, "1.0+-0.1")))
