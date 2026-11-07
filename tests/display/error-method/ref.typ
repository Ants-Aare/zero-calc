// display.error-method: how the uncertainty was propagated (root of the sum of squares of the partial errors).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add: equal uncertainties are counted
  $sqrt(2 times (#num("0.1"))^2)$,
  // 2: add: different uncertainties
  $sqrt((#num("0.1"))^2 + (#num("0.2"))^2)$,
  // 3: add: three equal ones
  $sqrt(3 times (#num("0.1"))^2)$,
  // 4: add: exact terms do not contribute
  $sqrt((#num("0.1"))^2)$,
  // 5: add: nothing uncertain is 0
  $0$,
  // 6: neg passes the error of the operand through
  $#num("0.1")$,
  // 7: abs passes the error of the operand through
  $#num("0.1")$,
  // 8: mul: relative errors
  $#num("6") times sqrt((#num("0.1")/#num("2.0"))^2 + (#num("0.1")/#num("3.0"))^2)$,
  // 9: mul: one uncertain factor
  $#num("6") times sqrt((#num("0.1")/#num("2.0"))^2)$,
  // 10: mul: identical relative errors are counted
  $#num("4") times sqrt(2 times (#num("0.1")/#num("2.0"))^2)$,
  // 11: div: relative errors
  $#num("2") times sqrt((#num("0.1")/#num("6.0"))^2 + (#num("0.1")/#num("3.0"))^2)$,
  // 12: pow: base
  $sqrt((#num("2") times #num("9") times #num("0.1")/#num("3.0"))^2)$,
  // 13: pow: exponent
  $sqrt((#num("8") dot ln(#num("2.0")) dot #num("0.1"))^2)$,
  // 14: pow: nothing uncertain
  $0$,
  // 15: log: value
  $sqrt((#num("1") / (#num("100") dot ln(#num("10"))))^2)$,
  // 16: sin
  $abs(cos(#num("1.00"))) dot #num("0.01")$,
  // 17: cos
  $abs(sin(#num("1.00"))) dot #num("0.01")$,
  // 18: tan
  $#num("0.01") / cos^2(#num("1.00"))$,
  // 19: arcsin
  $#num("0.01") / sqrt(1 - #num("0.50")^2)$,
  // 20: arccos
  $#num("0.01") / sqrt(1 - #num("0.50")^2)$,
  // 21: arctan
  $#num("0.01") / (1 + #num("1.00")^2)$,
  // 22: sin without uncertainty
  $0$,
  // 23: constants have no error
  $#num("6") times sqrt((#num("0.1")/#num("2.0"))^2)$,
  // 24: nested: error of an error
  $sqrt((#num("6") times sqrt((#num("0.1")/#num("2.0"))^2 + (#num("0.1")/#num("3.0"))^2))^2 + (#num("0.2"))^2)$,
  // 25: depth 0 shows only the error
  $#num("0.4")$,
)
