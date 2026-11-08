#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add(2.0, m)
  zcalc.add("2.0", zi.m("1.0")),
  // // 2: sub(2.0, m)
  zcalc.sub("2.0", zi.m("1.0")),
)
