/// [skip]
// BUG: a sub-result that is collapsed by `depth:` is still wrapped in parentheses.
//
// With depth: 1 the sum is shown as its plain result (3.0) but keeps the parentheses that belong to the expanded sum.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: mul(add, 3.0), depth 1
  $#num("3.0") times #num("3.0")$,
  // 2: pow(add, 2), depth 1
  $#num("3.0")^#num("2")$,
)
