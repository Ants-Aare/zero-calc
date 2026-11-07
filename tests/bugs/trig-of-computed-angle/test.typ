/// [skip]
// BUG: sin/cos/tan panic for angles that went through mul/div/pow.
//
// Unit arithmetic stores unit names in dictionaries, which turns the symbol `°` into the string "°".
// The trig functions then check `unit in (sym.degree, "rad", ...)`, which fails for the string.
// Angles from asin/acos/atan show the same problem as soon as they are multiplied.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin(15.0 deg * 2.0)
  check(zcalc.sin(zcalc.mul(zi.degree("15.0"), "2.0")), float: 0.5),
  // 2: cos(60.0 deg / 2.0)
  check(zcalc.cos(zcalc.div(zi.degree("60.0"), "2.0")), float: 0.8660254037844387),
  // 3: sin(2 * asin(0.50))
  check(zcalc.sin(zcalc.mul(zcalc.asin("0.50"), "2.0")), float: 0.8660254037844386),
  // 4: tan(rad * 2.0)
  check(zcalc.tan(zcalc.mul(zi.rad("0.25"), "2.0")), float: 0.5463024898437905),
)
