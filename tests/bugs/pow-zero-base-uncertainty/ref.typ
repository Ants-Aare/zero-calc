/// [skip]
// BUG: pow drops the uncertainty of a base that is exactly 0.
//
// The error term is skipped for `base-float == 0` because of the division by |base|, but
// d(x^n) = n |x|^(n-1) dx is fine at 0 for n >= 1: pow(0.0 +- 0.1, 1) must keep its +- 0.1.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: pow(0.0 +- 0.1, 1)
  num("0.0+-0.1"),
  // 2: pow(0.0 +- 0.1, 2) is 0 +- 0
  num("0+-0"),
)
