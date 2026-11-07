// zcalc.neg: sign flip. Digits, uncertainty and unit are kept.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: positive integer
  num("-5"),
  // 2: negative integer
  num("10"),
  // 3: decimal
  num("-5.0"),
  // 4: with uncertainty
  num("-19.816286+-0.1e2"),
  // 5: exponent notation
  num("-1.5e3"),
  // 6: float argument
  num("-2.5"),
  // 7: int argument
  num("-7"),
  // 8: double negation
  num("5.0+-0.1"),
  // 9: triple negation
  num("-5.0"),
  // 10: negated constant
  num(-calc.pi),
  // 11: neg of a sum
  num("-4.0"),
  // 12: neg of a product
  num("-6.0"),
  // 13: neg then add (plain)
  num("-4.0"),
  // 14: neg then mul (plain)
  num("-10"),
  // 15: neg then sub (plain)
  num("6.0"),
  // 16: neg then pow
  num("-27"),
  // 17: neg then abs
  num("5.0"),
  // 18: convert-si
  zi.m("-5.0e-3"),
  // 19: named argument
  num("-5.0e0", exponent: "sci"),
)
