// Operations return `none` when an operand is `none` (e.g. a missing value), so tables with gaps do not crash.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  repr(zcalc.add(none, "1")),
  // 2: add (second)
  repr(zcalc.add("1", none)),
  // 3: sub (minuend)
  repr(zcalc.sub(none, "1")),
  // 4: sub (subtrahend)
  repr(zcalc.sub("1", none)),
  // 5: mul
  repr(zcalc.mul(none, "2")),
  // 6: mul (second)
  repr(zcalc.mul("2", none)),
  // 7: div (dividend)
  repr(zcalc.div(none, "2")),
  // 8: div (divisor)
  repr(zcalc.div("2", none)),
  // 9: pow (base)
  repr(zcalc.pow(none, "2")),
  // 10: pow (exponent)
  repr(zcalc.pow("2", none)),
  // 11: exp
  repr(zcalc.exp(none)),
  // 12: sqrt
  repr(zcalc.sqrt(none)),
  // 13: root (radicand)
  repr(zcalc.root(none, "3")),
  // 14: root (index)
  repr(zcalc.root("8", none)),
  // 15: log (value)
  repr(zcalc.log(none, "10")),
  // 16: log (base)
  repr(zcalc.log("10", none)),
  // 17: ln
  repr(zcalc.ln(none)),
  // 18: abs
  repr(zcalc.abs(none)),
  // 19: neg
  repr(zcalc.neg(none)),
  // 20: convert-units-to-si
  repr(zcalc.convert-units-to-si(none)),
  // 21: none in the middle of a chain
  repr(zcalc.add(zcalc.mul(none, "2"), "1")),
  // 22: none in a long argument list
  repr(zcalc.add("1", "2", none, "3")),
  // 23: none is not zero
  repr(zcalc.mul("0", none)),
)
