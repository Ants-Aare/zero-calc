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
  zi.m("30e3", exponent: "eng"),
  // 9: round given at the call site
  num("2"),
  // 10: a later operand provides the defaults the first one does not set
  num("6.0", exponent: "sci"),
  // 11: the first operand wins over later ones
  num("2.0e4", exponent: "sci"),
  // 12: arguments of an inner result reach the outer operation
  num("7.0", exponent: "sci"),
  // 13: exponent operand of pow
  num("8.0", exponent: "sci"),
  // 14: divisor of div
  num("3.0", exponent: "sci"),
  // 15: base of log
  num("2.0", exponent: "sci"),
  // 16: subtrahend of sub
  num("3.0", exponent: "sci"),
  // 17: root index
  num("2.0", exponent: "sci"),
  // 18: alt text is dropped if the unit changes
  zi.declare("m s")("2.0"),
  // 19: alt text is kept if the unit stays
  num("3.0", alt: "one"),
  // 20: alt text is kept by neg
  num("-1.0", alt: "one"),
  // 21: alt text is dropped by div
  zi.declare("m/s")("2.0"),
  // 22: call-site arguments win over all operands
  num("6.0"),
  // 23: convert-si keeps the arguments
  zi.m("1.5e3", exponent: "sci"),
)
