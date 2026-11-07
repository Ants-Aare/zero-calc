// zcalc.exp: e to the power of a number (with optional uncertainty).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: e^1.00
  num("2.72"),
  // 2: e^1.0
  num("2.7"),
  // 3: e^2.0
  num("7.4"),
  // 4: e^-1.0
  num("3.7e-1"),
  // 5: e^10.0
  num("2.20e4"),
  // 6: uncertainty
  num("7.4+-0.7"),
  // 7: negative exponent with uncertainty
  num("1.35+-0.07e-1"),
  // 8: exp of ln
  num("5.0"),
  // 9: ln of exp
  num("2.50"),
  // 10: exp(0.0)
  num("1.0"),
)
