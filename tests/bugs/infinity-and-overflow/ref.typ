/// [skip]
// BUG: infinity and overflowing results crash instead of being shown as ∞.
//
// zcalc.inf is a valid constant and displays as ∞, but any operation that uses it (or overflows to
// infinity) panics: `calc.log(inf)` in get-value-e / round-float-noise ("the result is not a real number").
// `zcalc.add("1", zcalc.inf)` worked before round-float-noise was introduced.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: 1 + inf
  num(calc.inf),
  // 2: inf + inf
  num(calc.inf),
  // 3: 2 * inf
  num(calc.inf),
  // 4: 1e300 * 1e300 overflows
  num(calc.inf),
  // 5: 10 ^ 400 overflows
  num(calc.inf),
)
