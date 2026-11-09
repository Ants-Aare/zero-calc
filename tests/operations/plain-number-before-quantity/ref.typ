#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add(2.0, m)
  zi.m("3.0"),
  // 2: sub(2.0, m)
  zi.m("1.0"),
)
