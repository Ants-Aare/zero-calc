/// [skip]
// BUG: a sub-result that is collapsed by `depth:` is still wrapped in parentheses.
//
// With depth: 1 the sum is shown as its plain result (3.0) but keeps the parentheses that belong to the expanded sum.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: mul(add, 3.0), depth 1
  display.method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0"), depth: 1),
  // 2: pow(add, 2), depth 1
  display.method(zcalc.pow(zcalc.add("1.0", "2.0"), "2"), depth: 1),
)
