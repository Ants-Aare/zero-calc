// zcalc.neg: sign flip. Digits, uncertainty and unit are kept.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: positive integer
  check(zcalc.neg("5"), float: -5),
  // 2: negative integer
  check(zcalc.neg("-10"), float: 10),
  // 3: decimal
  check(zcalc.neg("5.0"), float: -5),
  // 4: with uncertainty
  check(zcalc.neg("19.816286+-0.1e2"), float: -1981.6286, uncertainty: 10),
  // 5: exponent notation
  check(zcalc.neg("1.5e3"), float: -1500),
  // 6: float argument
  check(zcalc.neg(2.5), float: -2.5),
  // 7: int argument
  check(zcalc.neg(7), float: -7),
  // 8: double negation
  check(zcalc.neg(zcalc.neg("5.0+-0.1")), float: 5, uncertainty: 0.1),
  // 9: triple negation
  check(zcalc.neg(zcalc.neg(zcalc.neg("5.0"))), float: -5),
  // 10: negated constant
  check(zcalc.neg(zcalc.pi), float: -calc.pi),
  // 11: neg of a sum
  check(zcalc.neg(zcalc.add("1.5", "2.5")), float: -4),
  // 12: neg of a product
  check(zcalc.neg(zcalc.mul("2.0", "3.0")), float: -6),
  // 13: neg then add (plain)
  check(zcalc.add(zcalc.neg("5.0"), "1.0"), float: -4),
  // 14: neg then mul (plain)
  check(zcalc.mul(zcalc.neg("5.0"), "2.0"), float: -10),
  // 15: neg then sub (plain)
  check(zcalc.sub("1.0", zcalc.neg("5.0")), float: 6),
  // 16: neg then pow
  check(zcalc.pow(zcalc.neg("3.0"), "3"), float: -27),
  // 17: neg then abs
  check(zcalc.abs(zcalc.neg("5.0")), float: 5),
  // 18: convert-si
  check(zcalc.neg(zi.mm("5.0"), convert-si: true), float: -0.005),
  // 19: named argument
  zcalc.neg("5.0", exponent: "sci"),
)
