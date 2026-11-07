// zcalc.abs: absolute value. Digits, uncertainty and unit are kept.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: positive integer
  check(zcalc.abs("5"), float: 5),
  // 2: negative decimal
  check(zcalc.abs("-5.0"), float: 5),
  // 3: zero
  check(zcalc.abs("0"), float: 0),
  // 4: negative zero
  zcalc.abs("-0.0"),
  // 5: with uncertainty
  check(zcalc.abs("-5.0+-0.2"), float: 5, uncertainty: 0.2),
  // 6: original: -19.816286+-0.1e2
  check(zcalc.abs("-19.816286+-0.1e2"), float: 1981.6286, uncertainty: 10),
  // 7: with unit
  check(zcalc.abs(zi.m("-5.0")), float: 5),
  // 8: compound unit
  zcalc.abs(zi.declare("m/s")("-5.0")),
  // 9: exponent notation
  check(zcalc.abs("-1.5e-5"), float: 1.5e-5),
  // 10: float argument
  check(zcalc.abs(-2.5), float: 2.5),
  // 11: int argument
  check(zcalc.abs(-3), float: 3),
  // 12: content argument
  zcalc.abs([-3.0+-0.1]),
  // 13: zero with uncertainty
  zcalc.abs("0.0+-0.1"),
  // 14: abs of abs
  check(zcalc.abs(zcalc.abs("-5.0")), float: 5),
  // 15: abs of a sum
  check(zcalc.abs(zcalc.add("-5.0", "2.0")), float: 3),
  // 16: abs of a difference
  check(zcalc.abs(zcalc.sub("2.0", "5.0")), float: 3),
  // 17: abs of a product
  check(zcalc.abs(zcalc.mul("-2.0", "3.0")), float: 6),
  // 18: abs of a quotient
  check(zcalc.abs(zcalc.div("-6.0", "3.0")), float: 2),
  // 19: abs of a negative constant
  check(zcalc.abs(zcalc.neg(zcalc.pi)), float: calc.pi),
  // 20: abs then add
  check(zcalc.add(zcalc.abs("-5.0"), "1.0"), float: 6),
  // 21: abs of a quantity then add
  check(zcalc.add(zcalc.abs(zi.m("-5.0")), zi.m("1.0")), float: 6),
  // 22: convert-si
  check(zcalc.abs(zi.mm("-5.0"), convert-si: true), float: 0.005),
)
