/// [skip]
// BUG: sqrt (and exp/log/ln/trig) accept `convert-si:` but ignore it.
//
// root(cm^3, 3, convert-si: true) returns metres, sqrt(cm^2, convert-si: true) silently returns centimetres.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sqrt(cm^2, convert-si)
  check(zcalc.sqrt(zi.declare("cm^2")("4.0"), convert-si: true), float: 0.02),
)
