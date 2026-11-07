// Named arguments (exponent:, round:, ...) of operands and of the call: the call wins, the first operand provides the defaults.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: exponent of the first operand is used
  zi.m("3.0", exponent: "sci"),
  // 2: call-site named argument
  num("3.0", exponent: "sci"),
  // 3: call-site round
  num("3.6"),
  // 4: abs: named argument
  num("5.0e0", exponent: "sci"),
  // 5: neg: named argument
  num("-5.0e0", exponent: "sci"),
  // 6: trig: named arguments
  num("5.00e-1", exponent: "sci"),
  // 7: exponent given at the call site
  num("2.0e4", exponent: "eng"),
  // 8: add: call site wins
  zi.m("30.0e3", exponent: "eng"),
  // 9: round given at the call site
  num("2"),
)
