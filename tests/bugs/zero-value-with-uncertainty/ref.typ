/// [skip]
// BUG: mul/div crash for a zero value with an uncertainty.
//
// mul/div compute the relative uncertainty u / x and divide by zero for x = 0. The absolute
// uncertainty of a product is perfectly well defined (|b| * u_a), and 0 +- u is a perfectly normal
// measurement (offsets, differences of nearly equal values, ...).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: mul(0 +- 1, 5)
  num("0+-5"),
  // 2: mul(5, 0 +- 1)
  num("0+-5"),
  // 3: div(0 +- 1, 5)
  num("0.0+-0.2"),
  // 4: mul(0.0 +- 0.1, 3.0 +- 0.1)
  num("0.0+-0.3"),
)
