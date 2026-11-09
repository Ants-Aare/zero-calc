// reference: accuracy given in places or in figures
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1
  num("3.7"),
  // 2
  num("7.0e-2"),
  // 3
  num("3.60"),
  // 4
  num("4.1e-1"),
  // 5
  num("1.5"),
  // 6
  num("1.414"),
  // 7
  num("2.51"),
  // 8
  num("1.1"),
  // 9
  num("0.500"),
  // 10
  zi.degree("31.561"),
  // 11
  num("4.2"),
  // 12
  num("1.8"),
  // 13
  num("-1.2"),
  // 14
  num("3.7"),
  // 15
  num("3.7+-0.2"),
  // 16
  num("4.23+-0.06"),
  // 17
  num("3.600+-0.300"),
  // 18
  num("1.41+-0.02"),
  // 19
  num("3.7"),
  // 20
  num("7.0e-2"),
  // 21
  zi.m("1.2e3"),
)
