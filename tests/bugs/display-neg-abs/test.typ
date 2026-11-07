/// [skip]
// BUG: display.method shows the already modified operand of neg() and abs().
//
// operations.neg / abs change `term.info.sign` *before* storing `term` as the source, so the history shows
// -(-5.0) for neg(5.0) and |5.0| for abs(-5.0).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: neg(5.0)
  display.method(zcalc.neg("5.0")),
  // 2: neg(-5.0)
  display.method(zcalc.neg("-5.0")),
  // 3: abs(-5.0)
  display.method(zcalc.abs("-5.0")),
  // 4: method-result of neg
  display.method-result(zcalc.neg("5.0")),
)
