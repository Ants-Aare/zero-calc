// zcalc.log (any base) and zcalc.ln.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: log10(100)
  zcalc.log("100", "10"),
  // 2: log10(100.0)
  zcalc.log("100.0", "10"),
  // 3: log with a 3 sig fig base
  zcalc.log("100.0", "10.0"),
  // 4: log2(8)
  zcalc.log("8.0", "2"),
  // 5: log(1) = 0
  zcalc.log("1.0", "10"),
  // 6: log10(0.001)
  zcalc.log("0.0010", "10"),
  // 7: log with fractional base
  zcalc.log("2.0", "0.5"),
  // 8: log of a huge number
  zcalc.log("1.0e300", "10"),
  // 9: original: log3(10)
  check(zcalc.log("10", "3"), float: 2.095903274289385),
  // 10: original: log10(1.3e3)
  check(zcalc.log("1.3e3", "10"), float: 3.1139433523068367),
  // 11: uncertainty of the value
  check(zcalc.log("100+-1", "10"), float: 2, uncertainty: 0.004342944819032518),
  // 12: uncertainty of the base
  check(zcalc.log("1.3e3", "10+-1"), float: 3.113943352306837, uncertainty: 0.13523684148661727),
  // 13: uncertainty of value and base
  check(zcalc.log("1+-0.4e3", "10+-1"), float: 3, uncertainty: 0.21714724095162588),
  // 14: ln(1) = 0
  zcalc.ln("1.0"),
  // 15: ln(10.0)
  check(zcalc.ln("10.0"), float: 2.302585092994046),
  // 16: ln(5.0)
  zcalc.ln("5.0"),
  // 17: ln(e) is exact
  zcalc.ln(zcalc.e),
  // 18: ln(0.5)
  check(zcalc.ln("0.50"), float: -0.6931471805599453),
  // 19: ln with uncertainty
  check(zcalc.ln("2.0+-0.1"), float: 0.6931471805599453, uncertainty: 0.05),
  // 20: ln of a large number
  check(zcalc.ln("1.0e10"), float: 23.025850929940457),
  // 21: log of a product
  check(zcalc.log(zcalc.mul("2.0", "5.0"), "10"), float: 1),
  // 22: ln of exp
  check(zcalc.ln(zcalc.exp("3.0")), float: 3),
)
