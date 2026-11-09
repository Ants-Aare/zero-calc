// add / sub decide the last digit by decimal places, but store it like every other operation: as significant figures
// (`precision`, `uncertainty-precision`, mode "figures"). The exponent is the one of the rounded result.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check, check-round
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 1.5 + 2.25 = 3.75, last digit is the tenth
  check-round(zcalc.add("1.5", "2.25"), precision: 2),
  // 2: 100 + 0.5 = 100.5, the coarsest digit is the unit
  check-round(zcalc.add("100", "0.5"), precision: 3),
  // 3: the sum has more digits than the operands (9.9 + 0.1)
  check-round(zcalc.add("9.9", "0.1"), precision: 3),
  // 4: carry: 9.96 + 0.0 rounds to 10.0
  check-round(zcalc.add("9.96", "0.0"), precision: 3),
  // 5: carry with uncertainties
  check-round(zcalc.add("9.96+-0.1", "0.0"), precision: 3, uncertainty-precision: 1),
  // 6: the sum cancels to zero and keeps its decimals
  zcalc.add("-5.0", "5.0"),
  // 7: a small sum rounds to zero
  zcalc.add("0.04", "-0.04"),
  // 8: the uncertainty decides the digit
  check-round(zcalc.add("1.50+-0.10", "2.5"), precision: 3, uncertainty-precision: 2),
  // 9: coarsest uncertainty
  check-round(zcalc.add("1.50+-0.10", "2.5+-0.2"), precision: 2, uncertainty-precision: 1),
  // 10: uncertainty with leading zeros
  check-round(zcalc.add("0.996+-0.0996", "0.0"), precision: 4, uncertainty-precision: 3),
  // 11: chained sums use the stored figures
  check-round(zcalc.add(zcalc.add("1.5", "2.25"), "0.125"), precision: 2),
  // 12: sub
  check-round(zcalc.sub("5.00", "1.2"), precision: 2),
  // 13: sub, cancellation loses significant figures
  check-round(zcalc.sub("1.002", "1.001"), precision: 1),
  // 14: plain operands give a plain sum
  zcalc.add("0.1", "0.2"),
  // 15: plain operands give a plain sum (3 digits)
  zcalc.add("100", "0.5"),
  // 16: exponent: the carry moves into the next order of magnitude
  zcalc.add("9.5e2", "5.0e1"),
  // 17: exponent: the sum is smaller than its operands
  zcalc.add("1.00e3", "-9.5e2"),
  // 18: exponent: sub
  zcalc.sub("1.00e-1", "9.5e-2"),
  // 19: exponent with uncertainty
  zcalc.add("9.5+-0.1e2", "5.0e1"),
  // 20: unit and exponent
  zcalc.add(zi.m("9.5e2"), zi.m("5.0e1")),
  // 21: eng exponent
  zcalc.add(zi.m("9.5e2", exponent: "eng"), zi.m("5.0e1")),
  // 22: sum of a quantity and a constant
  check-round(zcalc.add(zi.m("1.5"), zcalc.const("2")), precision: 2),
  // 23: only constants
  zcalc.add(zcalc.const("1.5"), zcalc.const("2.25")),
)
