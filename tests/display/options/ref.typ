// Options of the display functions: product, fraction, show-units, exponential and equals.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: product symbol
  $#num("2.0") dot #num("3.0")$,
  // 2: no product symbol
  $#num("2.0") #h(0.15em) #num("3.0")$,
  // 3: product symbol applies to all factors
  $#num("2.0") dot #num("3.0") dot #num("4.0")$,
  // 4: product symbol in nested products
  $#num("2.0") dot #num("3.0") + #num("1.0")$,
  // 5: inline fraction
  $#num("6.0") \/ #num("3.0")$,
  // 6: inline fraction: parentheses around sums
  $(#num("1.0") + #num("2.0")) \/ (#num("3.0") + #num("4.0"))$,
  // 7: inline fraction: parentheses around the product in the denominator
  $#num("6.0") \/ (#num("3.0") times #num("2.0"))$,
  // 8: inline fraction: parentheses around the quotient in the denominator
  $#num("6.0") \/ (#num("3.0") \/ #num("2.0"))$,
  // 9: inline fraction: a product in the numerator needs none
  $#num("6.0") times #num("3.0") \/ #num("2.0")$,
  // 10: units hidden
  $#num("2.0") times #num("3.0")$,
  // 11: units hidden in the result of method-result stay
  math.equation($ #num("2.0") times #num("3.0") = #zi.declare("m s")("6.0") $),
  // 12: exp as a function
  $exp(#num("2.0"))$,
  // 13: exp as a power
  $e^(#num("2.0"))$,
  // 14: equals symbol of method-result
  math.equation($ #num("1.5") + #num("2.25") approx #num("3.8") $),
  // 15: options of method-result
  math.equation($ #num("2.0") dot #num("3.0") \/ #num("4.0") = #num("1.5") $),
  // 16: equation arguments of method-result
  math.equation($ #num("1.5") + #num("2.25") = #num("3.8") $, numbering: "(1)"),
  // 17: depth with options
  $#num("6.0") dot #num("4.0")$,
  // 18: error-method product symbol
  $#num("6.0") dot sqrt((#num("0.1")/#num("2.0"))^2 + (#num("0.1")/#num("3.0"))^2)$,
  // 19: error-method without product symbol
  $sqrt((#num("2") #h(0.15em) #num("9.0") #h(0.15em) #num("0.1")/#num("3.0"))^2)$,
  // 20: error-method without units
  $#num("6.0") times sqrt((#num("0.1")/#num("2.0"))^2)$,
  // 21: error-method-result options
  math.equation($ #num("6.0") dot sqrt((#num("0.1")/#num("2.0"))^2) approx #num("0.3") $),
  // 22: error-method of a sum counts equal errors
  $sqrt(2 dot (#num("0.1"))^2)$,
  // 23: errors of the operands are shown
  $#num("2.0+-0.1") dot #num("3.0+-0.1")$,
  // 24
  $(#num("1.0") + #num("2.0")) times #num("4.0")$,
  // 25
  $#num("12.0") times sqrt((sqrt(2 times (#num("0.1"))^2)/#num("3.0"))^2)$,
  // 26
  num("0.6"),
  // 27
  $#num("1.5") + #num("2.25")$,
)
