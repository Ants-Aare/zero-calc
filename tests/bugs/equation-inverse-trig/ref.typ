/// [skip]
// BUG: arcsin / arccos / arctan inside an equation panic.
//
// The grammar produces the heads `arcsin`/`arccos`/`arctan`, apply-operations only knows `asin`/`acos`/`atan`
// and ends in panic(head). Unit and rounding of the result then follow zcalc.asin/acos/atan.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: arcsin(x)
  zi.degree("30"),
  // 2: arccos(x)
  zi.degree("60"),
  // 3: arctan(x)
  zi.degree("45"),
)
