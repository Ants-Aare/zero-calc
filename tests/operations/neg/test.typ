#import "/src/zero-calc.typ": *
#import impl.utility: *
#import "@preview/zero:0.7.0": *
#set page(width: auto, height: auto, margin: .5em)

#let x = zcalc.neg("10")
#assert(retrieve-metadata(x).float == -10)
#x\
#let x = zcalc.neg("-10")
#assert(retrieve-metadata(x).float == 10)
#x\
#let x = zcalc.neg("19.816286+-0.1e2")
#assert(retrieve-metadata(x).float == -1981.6286)
#x\
