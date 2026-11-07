/// [skip]
// BUG: display.method shows the already modified operand of neg() and abs().
//
// operations.neg / abs change `term.info.sign` *before* storing `term` as the source, so the history shows
// -(-5.0) for neg(5.0) and |5.0| for abs(-5.0).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: neg(5.0)
  $-#num("5.0")$,
  // 2: neg(-5.0)
  $-#num("-5.0")$,
  // 3: abs(-5.0)
  $abs(#num("-5.0"))$,
  // 4: method-result of neg
  math.equation($ -#num("5.0") = #num("-5.0") $),
)
