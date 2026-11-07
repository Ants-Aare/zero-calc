// zcalc.root / zcalc.sqrt.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sqrt(4)
  zcalc.sqrt("4"),
  // 2: sqrt(4.0)
  zcalc.sqrt("4.0"),
  // 3: sqrt(2) with 1 sig fig
  zcalc.sqrt("2"),
  // 4: sqrt(2.00)
  zcalc.sqrt("2.00"),
  // 5: sqrt(0)
  zcalc.sqrt("0"),
  // 6: sqrt(1.0e-6)
  zcalc.sqrt("1.0e-6"),
  // 7: sqrt(33.00)
  zcalc.sqrt("33.00"),
  // 8: sqrt of a big number
  zcalc.sqrt("1.0e10"),
  // 9: sqrt(float)
  zcalc.sqrt(2.25),
  // 10: cube root
  zcalc.root("8.0", "3"),
  // 11: cube root of a negative number
  zcalc.root("-8.0", "3"),
  // 12: fourth root, sig figs from the radicand
  zcalc.root("16.0", "4"),
  // 13: first root
  zcalc.root("16.0", "1"),
  // 14: decimal-looking integer index
  zcalc.root("16.0", "4.0"),
  // 15: negative index
  check(zcalc.root("8.0", "-3"), float: 0.5),
  // 16: original: 489^(1/3)
  check(zcalc.root("489", "3"), float: 7.878368425460935),
  // 17: unit square root
  zcalc.sqrt(zi.declare("m^2")("9.0")),
  // 18: unit cube root
  zcalc.root(zi.declare("m^3")("27.0"), "3"),
  // 19: compound unit square root
  zcalc.sqrt(zi.declare("m^2/s^2")("9.0")),
  // 20: convert-si converts the radicand
  check(zcalc.root(zi.declare("cm^3")("8.0"), "3", convert-si: true), float: 0.02),
  // 21: sqrt of a product
  zcalc.sqrt(zcalc.mul("2.0", "8.0")),
  // 22: hypotenuse
  check(zcalc.sqrt(zcalc.add(zcalc.pow("3.0", "2"), zcalc.pow("4.0", "2"))), float: 5),
  // 23: root(pow)
  check(zcalc.root(zcalc.pow("3.0", "3"), "3"), float: 3),
  // 24: decimal-looking index
  check(zcalc.root("489.0", "3.0"), float: 7.878368425460935),
  // 25: sqrt(cm^2, convert-si)
  check(zcalc.sqrt(zi.declare("cm^2")("4.0"), convert-si: true), float: 0.02),
  // 26: sqrt(9.0 +- 0.3)
  check(zcalc.sqrt("9.0+-0.3"), float: 3, uncertainty: 0.05),
  // 27: cbrt(27.0 +- 0.3)
  check(zcalc.root("27.0+-0.3", "3"), float: 3, uncertainty: 0.011111111111111112),
  // 28: 4th root of 16.0 +- 0.4
  check(zcalc.root("16.0+-0.4", "4"), float: 2, uncertainty: 0.0125),
  // 29: sqrt(100 +- 2)
  check(zcalc.sqrt("100+-2"), float: 10, uncertainty: 0.1),
  // 30: uncertain index: 489^(1/(3 +- 0.1))
  check(zcalc.root("489", "3+-0.10"), float: 7.878368425460935, uncertainty: 0.542063479067639),
)
