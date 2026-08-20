#import "/src/zero-calc.typ": *
#import impl.utility: *
#import "@preview/zero:0.7.0": *
#set page(width: auto, height: auto, margin: .5em)

#let x = zcalc.root("489", "3")
#assert(retrieve-metadata(x).float == 7.878368425460935)
#x\
#let x = zcalc.root("489.0", "3.0")
#assert(retrieve-metadata(x).float == 7.878368425460935)
#x\
#let x = zcalc.root("489", "3+-0.10")
#assert(retrieve-metadata(x).float == 7.878368425460935)
#x\
#let x = zcalc.sqrt("33.00")
#assert(retrieve-metadata(x).float == 5.744562646538029)
#x\
