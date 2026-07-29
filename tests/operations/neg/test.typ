#import "/src/lib.typ": *
#import impl.utility: *
#import "/src/lib/zero/src/zero.typ": *
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
