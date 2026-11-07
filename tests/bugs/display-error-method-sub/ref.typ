/// [skip]
// BUG: display.error-method panics for a subtraction.
//
// The source of sub() is (minuend, (subtrahends..)), error-method passes that nested array to the error
// deduplication which expects a flat list of values (add works, sub crashes with `expected integer, found string`).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sub
  $sqrt((#num("0.1"))^2 + (#num("0.2"))^2)$,
  // 2: sub, equal errors
  $sqrt(2 times (#num("0.1"))^2)$,
  // 3: error-method-result of sub
  math.equation($ sqrt((#num("0.1"))^2 + (#num("0.2"))^2) = #num("0.2") $),
)
