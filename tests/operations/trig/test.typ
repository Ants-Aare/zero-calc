// zcalc.sin / cos / tan with unitless (radian), rad, degree, arcminute and arcsecond angles.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin(0)
  zcalc.sin("0"),
  // 2: sin(1.0 rad)
  check(zcalc.sin("1.0"), float: 0.8414709848078965),
  // 3: sin(pi/2)
  check(zcalc.sin(zcalc.div(zcalc.pi, "2")), float: 1),
  // 4: sin(30 deg)
  check(zcalc.sin(zi.degree("30")), float: 0.5),
  // 5: sin(30.0 deg)
  check(zcalc.sin(zi.degree("30.0")), float: 0.5),
  // 6: sin(90.0 deg)
  check(zcalc.sin(zi.degree("90.0")), float: 1),
  // 7: sin(-30.0 deg)
  check(zcalc.sin(zi.degree("-30.0")), float: -0.5),
  // 8: sin(0.52 rad)
  check(zcalc.sin(zi.rad("0.52")), float: 0.49688013784373675),
  // 9: sin(1.00 rad)
  check(zcalc.sin(zi.rad("1.00")), float: 0.8414709848078965),
  // 10: sin(90.0 arcmin)
  check(zcalc.sin(zi.arcminute("90.0")), float: 0.026176948307873153),
  // 11: sin(5400.0 arcsec)
  check(zcalc.sin(zi.arcsecond("5400.0")), float: 0.026176948307873153),
  // 12: sin(1e5 arcsec) (existing)
  check(zcalc.sin(zi.arcsecond("1e5")), float: 0.4660435197025388),
  // 13: sin(1.00 rad) with uncertainty
  check(zcalc.sin(zi.rad("1.00+-0.01")), float: 0.8414709848078965, uncertainty: 0.005403023058681398),
  // 14: sin of an unitless number with uncertainty
  check(zcalc.sin("1.00+-0.01"), float: 0.8414709848078965, uncertainty: 0.005403023058681398),
  // 15: sin of a negative number
  zcalc.sin("-1.0"),
  // 16: cos(0.0 rad) ... see bugs
  check(zcalc.cos("1.0"), float: 0.5403023058681398),
  // 17: cos(60.0 deg)
  check(zcalc.cos(zi.degree("60.0")), float: 0.5),
  // 18: cos(-60.0 deg) is even
  check(zcalc.cos(zi.degree("-60.0")), float: 0.5),
  // 19: cos(1.00 rad)
  check(zcalc.cos(zi.rad("1.00")), float: 0.5403023058681398),
  // 20: cos(3.6e3 arcmin) (existing)
  check(zcalc.cos(zi.arcminute("3.6e3")), float: 0.5),
  // 21: cos(2.1e5 arcsec) (existing)
  check(zcalc.cos(zi.arcsecond("2.1e5")), float: 0.5249765803345602),
  // 22: cos(pi) of a constant keeps all digits
  check(zcalc.cos(zcalc.pi), float: -1),
  // 23: cos(1.00 rad) with uncertainty
  check(zcalc.cos(zi.rad("1.00+-0.01")), float: 0.5403023058681398, uncertainty: 0.008414709848078966),
  // 24: tan(0.0)
  zcalc.tan("0.0"),
  // 25: tan(45.0 deg)
  check(zcalc.tan(zi.degree("45.0")), float: 1),
  // 26: tan(-45.0 deg)
  check(zcalc.tan(zi.degree("-45.0")), float: -1),
  // 27: tan(0.5 rad) uses exponent notation below 1
  check(zcalc.tan("0.5"), float: 0.5463024898437905),
  // 28: tan(89.0 deg)
  check(zcalc.tan(zi.degree("89.0")), float: 57.289961630759144),
  // 29: tan(2700.0 arcmin)
  check(zcalc.tan(zi.arcminute("2700.0")), float: 1),
  // 30: tan(1.00 rad) with uncertainty
  check(zcalc.tan(zi.rad("1.00+-0.01")), float: 1.557407724654902, uncertainty: 0.03425518820814759),
  // 31: tan = sin / cos
  check(zcalc.div(zcalc.sin(zi.degree("30.0")), zcalc.cos(zi.degree("30.0"))), float: 0.5773502691896256),
  // 32: sin of a sum of angles
  check(zcalc.sin(zcalc.add(zi.degree("20.0"), zi.degree("10.0"))), float: 0.5),
  // 33: named arguments
  zcalc.sin(zi.degree("30.0"), exponent: "sci"),
  // 34: sin(1.8e3 arcmin)
  check(zcalc.sin(zi.arcminute("1.8e3")), float: 0.5),
  // 35: cos(60 deg)
  check(zcalc.cos(zi.degree("60")), float: 0.5),
  // 36: cos(1 rad)
  check(zcalc.cos(zi.rad("1")), float: 0.5403023058681398),
)
