// display.variable: a single value, optionally without its uncertainty.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: value with uncertainty
  display.variable(zcalc.add("1.5+-0.1", "2.5+-0.1")),
  // 2: show-error: false drops the uncertainty
  display.variable(zcalc.add("1.5+-0.1", "2.5+-0.1"), show-error: false),
  // 3: show-error: false with a larger uncertainty
  display.variable(zcalc.mul("2.0+-0.1", "3.0+-0.1"), show-error: false),
  // 4: plain number
  display.variable("1.50"),
  // 5: quantity
  display.variable(zcalc.mul(zi.m("2.0"), zi.s("3.0"))),
  // 6: quantity without uncertainty
  display.variable(zi.m("2.0+-0.1"), show-error: false),
  // 7: round arguments of the operands
  display.variable(zcalc.add(zi.m("0.4285714+-1.23456", round: (precision: 3, mode: "places", uncertainty-precision: (places: 1))), zi.m("0.8571428+-1.23456", round: (precision: 3, mode: "places", uncertainty-precision: (places: 1))))),
  // 8: round arguments, error hidden
  display.variable(zcalc.add(zi.m("0.4285714+-1.23456", round: (precision: 3, mode: "places", uncertainty-precision: (places: 1))), zi.m("0.8571428+-1.23456", round: (precision: 3, mode: "places", uncertainty-precision: (places: 1)))), show-error: false),
)
