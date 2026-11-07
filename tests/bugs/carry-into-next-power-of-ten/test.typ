/// [skip]
// BUG: rounding that carries into a new digit loses the significant figures information.
//
// 99.99 rounded to 2 significant figures is 1.0e2, but 100 is printed, which looks like 3 significant figures.
// normalise-exponent fixes this only for results that already have an exponent (9.996e-3 -> 1.00e-2).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 9.9 * 10.1
  zcalc.mul("9.9", "10.1"),
  // 2: 9.5 * 10.5
  zcalc.mul("9.5", "10.5"),
)
