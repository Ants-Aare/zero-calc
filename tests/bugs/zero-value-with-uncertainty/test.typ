/// [skip]
// BUG: mul/div crash for a zero value with an uncertainty.
//
// mul/div compute the relative uncertainty u / x and divide by zero for x = 0. The absolute
// uncertainty of a product is perfectly well defined (|b| * u_a), and 0 +- u is a perfectly normal
// measurement (offsets, differences of nearly equal values, ...).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: mul(0 +- 1, 5)
  check(zcalc.mul("0+-1", "5"), float: 0, uncertainty: 5),
  // 2: mul(5, 0 +- 1)
  check(zcalc.mul("5", "0+-1"), float: 0, uncertainty: 5),
  // 3: div(0 +- 1, 5)
  check(zcalc.div("0+-1", "5"), float: 0, uncertainty: 0.2),
  // 4: mul(0.0 +- 0.1, 3.0 +- 0.1)
  check(zcalc.mul("0.0+-0.1", "3.0+-0.1"), float: 0, uncertainty: 0.30000000000000004),
)
