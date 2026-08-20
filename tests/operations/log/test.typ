#import "/src/zero-calc.typ": *
#import impl.utility: *
#import "@preview/zero:0.7.0": *
#set page(width: auto, height: auto, margin: .5em)

#let x = zcalc.log("10", "3")
#x\
#let x = zcalc.log("1.3e3", "10")
#x\
#let x = zcalc.log("1.3e3", "10+-1")
#x\
#let x = zcalc.log("1+-0.4e3", "10+-1")
#x\
