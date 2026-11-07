// zcalc.root / zcalc.sqrt.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sqrt(4)
  num("2"),
  // 2: sqrt(4.0)
  num("2.0"),
  // 3: sqrt(2) with 1 sig fig
  num("1"),
  // 4: sqrt(2.00)
  num("1.41"),
  // 5: sqrt(0)
  num("0"),
  // 6: sqrt(1.0e-6)
  num("1.0e-3"),
  // 7: sqrt(33.00)
  num("5.745"),
  // 8: sqrt of a big number
  num("1.0e5"),
  // 9: sqrt(float)
  num("1.50"),
  // 10: cube root
  num("2.0"),
  // 11: cube root of a negative number
  num("-2.0"),
  // 12: fourth root, sig figs from the radicand
  num("2.00"),
  // 13: first root
  num("16.0"),
  // 14: decimal-looking integer index
  num("2.00"),
  // 15: negative index
  num("5.0e-1"),
  // 16: original: 489^(1/3)
  num("7.88"),
  // 17: unit square root
  zi.m("3.0"),
  // 18: unit cube root
  zi.m("3.00"),
  // 19: compound unit square root
  zi.declare("m/s")("3.0"),
  // 20: convert-si converts the radicand
  zi.m("2.0e-2"),
  // 21: sqrt of a product
  num("4.0"),
  // 22: hypotenuse
  num("5.0"),
  // 23: root(pow)
  num("3.0"),
  // 24: decimal-looking index
  num("7.878"),
  // 25: sqrt(cm^2, convert-si)
  zi.m("2.0e-2"),
  // 26: sqrt(9.0 +- 0.3)
  num("3.00+-0.05"),
  // 27: cbrt(27.0 +- 0.3)
  num("3.00+-0.01"),
  // 28: 4th root of 16.0 +- 0.4
  num("2.00+-0.01"),
  // 29: sqrt(100 +- 2)
  num("10.0+-0.1"),
  // 30: uncertain index: 489^(1/(3 +- 0.1))
  num("7.88+-0.54"),
)
