// display.method: the calculation that led to a value, as a math expression with the operands.
// Operands are always shown unrounded to their own precision, the structure (parentheses, fractions, roots) follows the operation.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  display.method(zcalc.add("1.5", "2.25")),
  // 2: add, many terms
  display.method(zcalc.add("1.0", "2.0", "3.0")),
  // 3: sub
  display.method(zcalc.sub("5.0", "2.0", "1.0")),
  // 4: mul uses the product symbol
  display.method(zcalc.mul("2.0", "3.0")),
  // 5: mul, many factors
  display.method(zcalc.mul("2.0", "3.0", "4.0")),
  // 6: div is a fraction
  display.method(zcalc.div("6.0", "3.0")),
  // 7: pow
  display.method(zcalc.pow("2.0", "3")),
  // 8: exp is e^x
  display.method(zcalc.exp("2.0")),
  // 9: pow with base e is e^x
  display.method(zcalc.pow(zcalc.e, "2.0")),
  // 10: sqrt
  display.method(zcalc.sqrt("4.0")),
  // 11: root
  display.method(zcalc.root("8.0", "3")),
  // 12: log
  display.method(zcalc.log("100", "10")),
  // 13: ln
  display.method(zcalc.ln("5.0")),
  // 14: sin
  display.method(zcalc.sin("1.0")),
  // 15: cos
  display.method(zcalc.cos("1.0")),
  // 16: tan
  display.method(zcalc.tan("1.0")),
  // 17: arcsin
  display.method(zcalc.asin("0.5")),
  // 18: arccos
  display.method(zcalc.acos("0.5")),
  // 19: arctan
  display.method(zcalc.atan("0.5")),
  // 20: units are shown on the operands
  display.method(zcalc.mul(zi.m("2.0"), zi.s("3.0"))),
  // 21: conversion to SI
  display.method(zcalc.convert-units-to-si(zi.km("1.5"))),
  // 22: add inside mul gets parentheses
  display.method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0")),
  // 23: mul inside add needs none
  display.method(zcalc.add(zcalc.mul("1.0", "2.0"), "3.0")),
  // 24: add inside sub
  display.method(zcalc.sub("5.0", zcalc.add("1.0", "2.0"))),
  // 25: sub inside sub
  display.method(zcalc.sub("5.0", zcalc.sub("4.0", "1.0"))),
  // 26: sub inside add needs none
  display.method(zcalc.add(zcalc.sub("4.0", "1.0"), "5.0")),
  // 27: neg of a sum
  display.method(zcalc.neg(zcalc.add("1.0", "2.0"))),
  // 28: abs of a sum
  display.method(zcalc.abs(zcalc.add("1.0", "-2.0"))),
  // 29: sum as a power base
  display.method(zcalc.pow(zcalc.add("1.0", "2.0"), "2")),
  // 30: product as a power base
  display.method(zcalc.pow(zcalc.mul("2.0", "3.0"), "2")),
  // 31: power inside a product
  display.method(zcalc.mul(zcalc.pow("2.0", "2"), "3.0")),
  // 32: sum in a fraction needs none
  display.method(zcalc.div(zcalc.add("1.0", "2.0"), "3.0")),
  // 33: fraction inside a product
  display.method(zcalc.mul(zcalc.div("6.0", "3.0"), "2.0")),
  // 34: product inside a product
  display.method(zcalc.mul(zcalc.mul("2.0", "3.0"), "4.0")),
  // 35: sqrt of a sum
  display.method(zcalc.sqrt(zcalc.add(zcalc.pow("3.0", "2"), zcalc.pow("4.0", "2")))),
  // 36: sin of a product
  display.method(zcalc.sin(zcalc.mul("2.0", "3.0"))),
  // 37: depth 0 shows only the result
  display.method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0"), depth: 0),
  // 38: full depth
  display.method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0"), depth: 2),
  // 39: a constant is shown with all its digits
  display.method(zcalc.mul("2.0", zcalc.pi)),
  // 40: equation result
  display.method(equation.define($(a + b) c$)(a: "1.0", b: "2.0", c: "3.0")),
  // 41: equation result with depth 1 stops at variables
  display.method(equation.define($(a + b) c$)(a: zcalc.add("1.0", "1.0"), b: "2.0", c: "3.0"), depth: 1),
)
