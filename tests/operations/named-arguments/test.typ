// Named arguments (exponent:, round:, ...) of operands and of the call: the call wins, the first operand provides the defaults.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: exponent of the first operand is used
  zcalc.add(zi.m("1.0", exponent: "sci"), zi.m("2.0")),
  // 2: call-site named argument
  zcalc.add("1.0", "2.0", exponent: "sci"),
  // 3: call-site round
  zcalc.add("1.234", "2.345", round: (precision: 1, mode: "places")),
  // 4: abs: named argument
  zcalc.abs("-5.0", exponent: "sci"),
  // 5: neg: named argument
  zcalc.neg("5.0", exponent: "sci"),
  // 6: trig: named arguments
  zcalc.sin(zi.degree("30.0"), exponent: "sci"),
  // 7: exponent given at the call site
  zcalc.mul(num("1.0e4", exponent: "sci"), "2.0", exponent: "eng"),
  // 8: add: call site wins
  zcalc.add(zi.m("1.0e4", exponent: "sci"), zi.m("2.0e4"), exponent: "eng"),
  // 9: round given at the call site
  zcalc.mul(num("1.234", round: (precision: 3, mode: "figures")), "2.0", round: (precision: 1, mode: "figures")),
)
