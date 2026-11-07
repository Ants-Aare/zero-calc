/// [skip]
// BUG: sqrt (and exp/log/ln/trig) accept `convert-si:` but ignore it.
//
// root(cm^3, 3, convert-si: true) returns metres, sqrt(cm^2, convert-si: true) silently returns centimetres.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sqrt(cm^2, convert-si)
  zi.m("2.0e-2"),
)
