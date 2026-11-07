// display.variable: a single value, optionally without its uncertainty.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: value with uncertainty
  num("4.0+-0.1"),
  // 2: show-error: false drops the uncertainty
  num("4.0"),
  // 3: show-error: false with a larger uncertainty
  num("6"),
  // 4: plain number
  num("1.50"),
  // 5: quantity
  zi.declare("m s")("6.0"),
  // 6: quantity without uncertainty
  zi.m("2.0"),
  // 7: round arguments of the operands
  zi.m("1.3+-1.7"),
  // 8: round arguments, error hidden
  zi.m("1.3"),
)
