// zcalc.exp: e to the power of a number (with optional uncertainty).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: e^1.00
  zcalc.exp("1.00"),
  // 2: e^1.0
  zcalc.exp("1.0"),
  // 3: e^2.0
  zcalc.exp("2.0"),
  // 4: e^-1.0
  check(zcalc.exp("-1.0"), float: 0.36787944117144233),
  // 5: e^10.0
  check(zcalc.exp("10.0"), float: 22026.465794806718),
  // 6: uncertainty
  check(zcalc.exp("2.0+-0.1"), float: 7.38905609893065, uncertainty: 0.7389056098930651),
  // 7: negative exponent with uncertainty
  check(zcalc.exp("-2.00+-0.05"), float: 0.1353352832366127, uncertainty: 0.0067667641618306355),
  // 8: exp of ln
  check(zcalc.exp(zcalc.ln("5.0")), float: 5),
  // 9: ln of exp
  check(zcalc.ln(zcalc.exp("2.50")), float: 2.5),
)
