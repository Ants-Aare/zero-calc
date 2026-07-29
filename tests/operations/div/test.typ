#import "/src/lib.typ": *
#import impl.utility: *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)

#let x = zcalc.div("22", "2+-0.1")
// #assert(retrieve-metadata(x).float == 44)
#x\
#let x = zcalc.div("22+-0.001234", "3")
// #assert(retrieve-metadata(x).float == 66)
#x\
#let x = zcalc.div("123.456+-30", "2")
// #assert(retrieve-metadata(x).float == 246.912)
#x
#let x = zcalc.div("2.49", "4.0")
// #assert(retrieve-metadata(x).float == 9.96)
#x\
#let x = zcalc.div("1.5e3", "4.0e-2")
// #assert(retrieve-metadata(x).float == 60)
#x
#let x = zcalc.div("1.00e2", "3.0")
// #assert(retrieve-metadata(x).float == 300)
#x\
#let x = zcalc.div("22", "2")
// #assert(retrieve-metadata(x).float == 44)
#x
#let x = zcalc.div("2.0e-3", "3.0e-4")
// #assert(retrieve-metadata(x).float == 0.0000006)
#x\
#let x = zcalc.div("5.00+-0.02e-1", "2.0e2")
// #assert(retrieve-metadata(x).float == 100)
#x\
#let x = zcalc.div("-5.0+-0.2", "3.0")
// #assert(retrieve-metadata(x).float == -15.0)
#x\
