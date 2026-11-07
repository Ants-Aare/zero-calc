/// [skip]
// BUG: neg(0) is displayed as `−0`.
//
// A signed zero has no meaning for a number: -0 and -0.0 should be displayed as 0 and 0.0
// (sub("0", "0") and add("-0", "-0") already do).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: neg(0)
  num("0"),
  // 2: neg(0.0)
  num("0.0"),
  // 3: neg(0.0 +- 0.1)
  num("0.0+-0.1"),
)
