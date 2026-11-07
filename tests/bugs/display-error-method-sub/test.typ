/// [skip]
// BUG: display.error-method panics for a subtraction.
//
// The source of sub() is (minuend, (subtrahends..)), error-method passes that nested array to the error
// deduplication which expects a flat list of values (add works, sub crashes with `expected integer, found string`).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sub
  display.error-method(zcalc.sub("5.0+-0.1", "2.0+-0.2")),
  // 2: sub, equal errors
  display.error-method(zcalc.sub("5.0+-0.1", "2.0+-0.1")),
  // 3: error-method-result of sub
  display.error-method-result(zcalc.sub("5.0+-0.1", "2.0+-0.2")),
)
