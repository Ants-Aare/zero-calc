// zcalc.abs: absolute value. Digits, uncertainty and unit are kept.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: positive integer
  num("5"),
  // 2: negative decimal
  num("5.0"),
  // 3: zero
  num("0"),
  // 4: negative zero
  num("0.0"),
  // 5: with uncertainty
  num("5.0+-0.2"),
  // 6: original: -19.816286+-0.1e2
  num("19.816286+-0.1e2"),
  // 7: with unit
  zi.m("5.0"),
  // 8: compound unit
  zi.declare("m/s")("5.0"),
  // 9: exponent notation
  num("1.5e-5"),
  // 10: float argument
  num("2.5"),
  // 11: int argument
  num("3"),
  // 12: content argument
  num("3.0+-0.1"),
  // 13: zero with uncertainty
  num("0.0+-0.1"),
  // 14: abs of abs
  num("5.0"),
  // 15: abs of a sum
  num("3.0"),
  // 16: abs of a difference
  num("3.0"),
  // 17: abs of a product
  num("6.0"),
  // 18: abs of a quotient
  num("2.0"),
  // 19: abs of a negative constant
  num(calc.pi),
  // 20: abs then add
  num("6.0"),
  // 21: abs of a quantity then add
  zi.m("6.0"),
  // 22: convert-si
  zi.m("5.0e-3"),
)
