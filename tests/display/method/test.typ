// display.method: the calculation that led to a value, as a math expression with the operands.
// Operands are always shown unrounded to their own precision, the structure (parentheses, fractions, roots) follows the operation.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)
#let method = display.method.with(show-result: false)

#cases(
  // 1: add
  method(zcalc.add("1.5", "2.25")),
  // 2: add, many terms
  method(zcalc.add("1.0", "2.0", "3.0")),
  // 3: sub
  method(zcalc.sub("5.0", "2.0", "1.0")),
  // 4: mul uses the product symbol
  method(zcalc.mul("2.0", "3.0")),
  // 5: mul, many factors
  method(zcalc.mul("2.0", "3.0", "4.0")),
  // 6: div is a fraction
  method(zcalc.div("6.0", "3.0")),
  // 7: pow
  method(zcalc.pow("2.0", "3")),
  // 8: exp is e^x
  method(zcalc.exp("2.0")),
  // 9: pow with base e is e^x
  method(zcalc.pow(zcalc.e, "2.0")),
  // 10: sqrt
  method(zcalc.sqrt("4.0")),
  // 11: root
  method(zcalc.root("8.0", "3")),
  // 12: log
  method(zcalc.log("100", "10")),
  // 13: ln
  method(zcalc.ln("5.0")),
  // 14: sin
  method(zcalc.sin("1.0")),
  // 15: cos
  method(zcalc.cos("1.0")),
  // 16: tan
  method(zcalc.tan("1.0")),
  // 17: arcsin
  method(zcalc.asin("0.5")),
  // 18: arccos
  method(zcalc.acos("0.5")),
  // 19: arctan
  method(zcalc.atan("0.5")),
  // 20: units are shown on the operands
  method(zcalc.mul(zi.m("2.0"), zi.s("3.0"))),
  // 21: conversion to SI
  method(zcalc.convert-units-to-si(zi.km("1.5"))),
  // 22: add inside mul gets parentheses
  method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0")),
  // 23: mul inside add needs none
  method(zcalc.add(zcalc.mul("1.0", "2.0"), "3.0")),
  // 24: add inside sub
  method(zcalc.sub("5.0", zcalc.add("1.0", "2.0"))),
  // 25: sub inside sub
  method(zcalc.sub("5.0", zcalc.sub("4.0", "1.0"))),
  // 26: sub inside add needs none
  method(zcalc.add(zcalc.sub("4.0", "1.0"), "5.0")),
  // 27: neg of a sum
  method(zcalc.neg(zcalc.add("1.0", "2.0"))),
  // 28: abs of a sum
  method(zcalc.abs(zcalc.add("1.0", "-2.0"))),
  // 29: sum as a power base
  method(zcalc.pow(zcalc.add("1.0", "2.0"), "2")),
  // 30: product as a power base
  method(zcalc.pow(zcalc.mul("2.0", "3.0"), "2")),
  // 31: power inside a product
  method(zcalc.mul(zcalc.pow("2.0", "2"), "3.0")),
  // 32: sum in a fraction needs none
  method(zcalc.div(zcalc.add("1.0", "2.0"), "3.0")),
  // 33: fraction inside a product
  method(zcalc.mul(zcalc.div("6.0", "3.0"), "2.0")),
  // 34: product inside a product
  method(zcalc.mul(zcalc.mul("2.0", "3.0"), "4.0")),
  // 35: sqrt of a sum
  method(zcalc.sqrt(zcalc.add(zcalc.pow("3.0", "2"), zcalc.pow("4.0", "2")))),
  // 36: sin of a product
  method(zcalc.sin(zcalc.mul("2.0", "3.0"))),
  // 37: depth 0 shows only the result
  method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0"), depth: 0),
  // 38: full depth
  method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0"), depth: 2),
  // 39: a constant is shown with all its digits
  method(zcalc.mul("2.0", zcalc.pi)),
  // 40: equation result
  method(equation.define($(a + b) c$)(a: "1.0", b: "2.0", c: "3.0")),
  // 41: equation result with depth 1 stops at variables
  method(equation.define($(a + b) c$)(a: zcalc.add("1.0", "1.0"), b: "2.0", c: "3.0"), depth: 1),
  // 42: mul(add, 3.0), depth 1
  method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0"), depth: 1),
  // 43: pow(add, 2), depth 1
  method(zcalc.pow(zcalc.add("1.0", "2.0"), "2"), depth: 1),
  // 44: neg(5.0)
  method(zcalc.neg("5.0")),
  // 45: neg(-5.0)
  method(zcalc.neg("-5.0")),
  // 46: abs(-5.0)
  method(zcalc.abs("-5.0")),
)
