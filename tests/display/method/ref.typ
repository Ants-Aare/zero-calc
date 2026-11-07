// display.method: the calculation that led to a value, as a math expression with the operands.
// Operands are always shown unrounded to their own precision, the structure (parentheses, fractions, roots) follows the operation.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  $#num("1.5") + #num("2.25")$,
  // 2: add, many terms
  $#num("1.0") + #num("2.0") + #num("3.0")$,
  // 3: sub
  $#num("5.0") - #num("2.0") - #num("1.0")$,
  // 4: mul uses the product symbol
  $#num("2.0") times #num("3.0")$,
  // 5: mul, many factors
  $#num("2.0") times #num("3.0") times #num("4.0")$,
  // 6: div is a fraction
  $#num("6.0")/#num("3.0")$,
  // 7: pow
  $#num("2.0")^#num("3")$,
  // 8: exp is e^x
  $e^#num("2.0")$,
  // 9: pow with base e is e^x
  $e^#num("2.0")$,
  // 10: sqrt
  $sqrt(#num("4.0"))$,
  // 11: root
  $root(#num("3"), #num("8.0"))$,
  // 12: log
  $log_(#num("10"))(#num("100"))$,
  // 13: ln
  $ln(#num("5.0"))$,
  // 14: sin
  $sin(#num("1.0"))$,
  // 15: cos
  $cos(#num("1.0"))$,
  // 16: tan
  $tan(#num("1.0"))$,
  // 17: arcsin
  $arcsin(#num("0.5"))$,
  // 18: arccos
  $arccos(#num("0.5"))$,
  // 19: arctan
  $arctan(#num("0.5"))$,
  // 20: units are shown on the operands
  $#zi.m("2.0") times #zi.s("3.0")$,
  // 21: conversion to SI
  $#zi.km("1.5") times #zi.declare("m/km")("1e3", omit-unity-mantissa: true)$,
  // 22: add inside mul gets parentheses
  $(#num("1.0") + #num("2.0")) times #num("3.0")$,
  // 23: mul inside add needs none
  $#num("1.0") times #num("2.0") + #num("3.0")$,
  // 24: add inside sub
  $#num("5.0") - (#num("1.0") + #num("2.0"))$,
  // 25: sub inside sub
  $#num("5.0") - (#num("4.0") - #num("1.0"))$,
  // 26: sub inside add needs none
  $#num("4.0") - #num("1.0") + #num("5.0")$,
  // 27: neg of a sum
  $-(#num("1.0") + #num("2.0"))$,
  // 28: abs of a sum
  $abs(#num("1.0") + #num("-2.0"))$,
  // 29: sum as a power base
  $(#num("1.0") + #num("2.0"))^#num("2")$,
  // 30: product as a power base
  $(#num("2.0") times #num("3.0"))^#num("2")$,
  // 31: power inside a product
  $#num("2.0")^#num("2") times #num("3.0")$,
  // 32: sum in a fraction needs none
  $(#num("1.0") + #num("2.0"))/#num("3.0")$,
  // 33: fraction inside a product
  $#num("6.0")/#num("3.0") times #num("2.0")$,
  // 34: product inside a product
  $#num("2.0") times #num("3.0") times #num("4.0")$,
  // 35: sqrt of a sum
  $sqrt(#num("3.0")^#num("2") + #num("4.0")^#num("2"))$,
  // 36: sin of a product
  $sin(#num("2.0") times #num("3.0"))$,
  // 37: depth 0 shows only the result
  $#num("9.0")$,
  // 38: full depth
  $(#num("1.0") + #num("2.0")) times #num("3.0")$,
  // 39: a constant is shown with all its digits
  $#num("2.0") times #num(calc.pi)$,
  // 40: equation result
  $(#num("1.0") + #num("2.0")) times #num("3.0")$,
  // 41: equation result with depth 1 stops at variables
  $(#num("2.0") + #num("2.0")) times #num("3.0")$,
  // 42: mul(add, 3.0), depth 1
  $#num("3.0") times #num("3.0")$,
  // 43: pow(add, 2), depth 1
  $#num("3.0")^#num("2")$,
  // 44: neg(5.0)
  $-#num("5.0")$,
  // 45: neg(-5.0)
  $-#num("-5.0")$,
  // 46: abs(-5.0)
  $abs(#num("-5.0"))$,
)
