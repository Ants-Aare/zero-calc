// display.method-result: `calculation = result` as one equation.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  display.method-result(zcalc.add("1.5", "2.25")),
  // 2: with uncertainty (default hides it)
  display.method-result(zcalc.add("1.5+-0.1", "2.5+-0.1")),
  // 3: show-error: true
  display.method-result(zcalc.add("1.5+-0.1", "2.5+-0.1"), show-error: true),
  // 4: quantities
  display.method-result(zcalc.div(zi.m("30+-0.3"), zi.s("5+-0.4"))),
  // 5: README example
  display.method-result(zcalc.pow(zcalc.div(zi.m("30+-1.45"), zi.s("5.0+-0.20")), 2)),
  // 6: conversion
  display.method-result(zcalc.convert-units-to-si(zi.km("1.5"))),
  // 7: conversion with a compound unit
  display.method-result(zcalc.convert-units-to-si(zi.km-h("3.6"))),
  // 8: method-result of neg
  display.method-result(zcalc.neg("5.0")),
)
