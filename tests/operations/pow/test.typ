#import "/src/zero-calc.typ": *
#import impl.utility: *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)

#let x = zcalc.pow("22.12", "2")
#assert(retrieve-metadata(x).float == 489.29440000000005)
#x\
#let x = zcalc.pow("22.12", "2.0")
#assert(retrieve-metadata(x).float == 489.29440000000005)
#x\
#let x = zcalc.pow("22.12", "2+-0.1")
#assert(retrieve-metadata(x).float == 489.29440000000005)
#x\
#let x = zcalc.exp("1.00")
#assert(retrieve-metadata(x).float == 2.7182818284590455)
#x\
