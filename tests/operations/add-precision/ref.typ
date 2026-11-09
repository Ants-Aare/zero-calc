// reference: add / sub precision
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1
  num("3.8"),
  // 2
  num("101"),
  // 3
  num("10.0"),
  // 4
  num("10.0"),
  // 5
  num("10.0+-0.1"),
  // 6
  num("0.0"),
  // 7
  num("0.00"),
  // 8
  num("4.00+-0.10"),
  // 9
  num("4.0+-0.2"),
  // 10
  num("0.9960+-0.0996"),
  // 11
  num("3.9"),
  // 12
  num("3.8"),
  // 13
  num("0.001"),
  // 14
  num("0.3"),
  // 15
  num("101"),
  // 16
  num("1.00e3"),
  // 17
  num("50"),
  // 18
  num("5e-3"),
  // 19
  num("1.00+-0.01e3"),
  // 20
  zi.m("1.00e3"),
  // 21
  zi.km("1.00"),
  // 22
  zi.m("3.5"),
  // 23
  num("3.75"),
)
