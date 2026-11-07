// Operations return `none` when an operand is `none` (e.g. a missing value), so tables with gaps do not crash.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  "none",
  // 2: add (second)
  "none",
  // 3: sub (minuend)
  "none",
  // 4: sub (subtrahend)
  "none",
  // 5: mul
  "none",
  // 6: mul (second)
  "none",
  // 7: div (dividend)
  "none",
  // 8: div (divisor)
  "none",
  // 9: pow (base)
  "none",
  // 10: pow (exponent)
  "none",
  // 11: exp
  "none",
  // 12: sqrt
  "none",
  // 13: root (radicand)
  "none",
  // 14: root (index)
  "none",
  // 15: log (value)
  "none",
  // 16: log (base)
  "none",
  // 17: ln
  "none",
  // 18: abs
  "none",
  // 19: neg
  "none",
  // 20: convert-units-to-si
  "none",
  // 21: none in the middle of a chain
  "none",
  // 22: none in a long argument list
  "none",
  // 23: none is not zero
  "none",
)
