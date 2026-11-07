/// [skip]
// BUG: infinity and overflowing results crash instead of being shown as ∞.
//
// zcalc.inf is a valid constant and displays as ∞, but any operation that uses it (or overflows to
// infinity) panics: `calc.log(inf)` in get-value-e / round-float-noise ("the result is not a real number").
// `zcalc.add("1", zcalc.inf)` worked before round-float-noise was introduced.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 1 + inf
  zcalc.add("1", zcalc.inf),
  // 2: inf + inf
  zcalc.add(zcalc.inf, zcalc.inf),
  // 3: 2 * inf
  zcalc.mul("2", zcalc.inf),
  // 4: 1e300 * 1e300 overflows
  zcalc.mul("1e300", "1e300"),
  // 5: 10 ^ 400 overflows
  zcalc.pow("10", "400"),
)
