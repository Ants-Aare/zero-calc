/// [skip]
// BUG: sin/cos/tan panic for angles that went through mul/div/pow.
//
// Unit arithmetic stores unit names in dictionaries, which turns the symbol `°` into the string "°".
// The trig functions then check `unit in (sym.degree, "rad", ...)`, which fails for the string.
// Angles from asin/acos/atan show the same problem as soon as they are multiplied.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin(15.0 deg * 2.0)
  num("0.50"),
  // 2: cos(60.0 deg / 2.0)
  num("0.87"),
  // 3: sin(2 * asin(0.50))
  num("0.87"),
  // 4: tan(rad * 2.0)
  num("0.5"),
)
