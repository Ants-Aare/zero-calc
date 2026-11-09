// Named arguments (exponent:, round:, ...) of operands and of the call: the call wins, the first operand provides the defaults.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check, check-args
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
  // 10: a later operand provides the defaults the first one does not set
  zcalc.mul("2.0", num("3.0", exponent: "sci")),
  // 11: the first operand wins over later ones
  zcalc.mul(num("1.0e4", exponent: "sci"), num("2.0", exponent: "eng")),
  // 12: arguments of an inner result reach the outer operation
  zcalc.add("1.0", zcalc.mul(num("2.0", exponent: "sci"), "3.0")),
  // 13: exponent operand of pow
  zcalc.pow("2.0", num("3", exponent: "sci")),
  // 14: divisor of div
  zcalc.div("6.0", num("2.0", exponent: "sci")),
  // 15: base of log
  zcalc.log("100", num("10", exponent: "sci")),
  // 16: subtrahend of sub
  zcalc.sub("5.0", num("2.0", exponent: "sci")),
  // 17: root index
  zcalc.root("8.0", num("3", exponent: "sci")),
  // 18: alt text is dropped if the unit changes
  check-args(zcalc.mul(zi.m("2.0", alt: "meter"), zi.s("1.0")), absent: ("alt",)),
  // 19: alt text is kept if the unit stays
  check-args(zcalc.add(num("1.0", alt: "one"), num("2.0")), expected: (alt: "one")),
  // 20: alt text is kept by neg
  check-args(zcalc.neg(num("1.0", alt: "one")), expected: (alt: "one")),
  // 21: alt text is dropped by div
  check-args(zcalc.div(zi.m("6.0", alt: "meter"), zi.s("3.0")), absent: ("alt",)),
  // 22: call-site arguments win over all operands
  zcalc.mul(num("2.0", exponent: "sci"), num("3.0", exponent: "eng"), exponent: auto),
  // 23: convert-si keeps the arguments
  zcalc.convert-units-to-si(zi.km("1.5", exponent: "sci")),
)
