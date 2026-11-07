// zcalc.log (any base) and zcalc.ln.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: log10(100)
  num("2.0"),
  // 2: log10(100.0)
  num("2.0"),
  // 3: log with a 3 sig fig base
  num("2.00"),
  // 4: log2(8)
  num("3"),
  // 5: log(1) = 0
  num("0"),
  // 6: log10(0.001)
  num("-3.0"),
  // 7: log with fractional base
  num("-1"),
  // 8: log of a huge number
  num("3.0e2"),
  // 9: original: log3(10)
  num("2"),
  // 10: original: log10(1.3e3)
  num("3.1"),
  // 11: uncertainty of the value
  num("2.000+-0.004"),
  // 12: uncertainty of the base
  num("3.1+-0.1"),
  // 13: uncertainty of value and base
  num("3.0+-0.2"),
  // 14: ln(1) = 0
  num("0"),
  // 15: ln(10.0)
  num("2.30"),
  // 16: ln(5.0)
  num("1.6"),
  // 17: ln(e) is exact
  num("1"),
  // 18: ln(0.5)
  num("-6.9e-1"),
  // 19: ln with uncertainty
  num("6.9+-0.5e-1"),
  // 20: ln of a large number
  num("23"),
  // 21: log of a product
  num("1.0"),
  // 22: ln of exp
  num("3.0"),
)
