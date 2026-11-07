/// [skip]
// BUG: root/sqrt propagate the uncertainty of the radicand and of the index with the wrong formula.
//
// For y = x^(1/n):  dy/dx = y / (n x)  and  dy/dn = -y ln(x) / n^2.
// The code multiplies by n instead of dividing (radicand term) and omits the 1/n^2 (index term),
// e.g. sqrt(9.0 +- 0.3) = 3.00 +- 0.05, but 3.0 +- 0.2 is printed.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sqrt(9.0 +- 0.3)
  check(zcalc.sqrt("9.0+-0.3"), float: 3, uncertainty: 0.05),
  // 2: cbrt(27.0 +- 0.3)
  check(zcalc.root("27.0+-0.3", "3"), float: 3, uncertainty: 0.011111111111111112),
  // 3: 4th root of 16.0 +- 0.4
  check(zcalc.root("16.0+-0.4", "4"), float: 2, uncertainty: 0.0125),
  // 4: sqrt(100 +- 2)
  check(zcalc.sqrt("100+-2"), float: 10, uncertainty: 0.1),
  // 5: uncertain index: 489^(1/(3 +- 0.1))
  check(zcalc.root("489", "3+-0.10"), float: 7.878368425460935, uncertainty: 0.542063479067639),
)
