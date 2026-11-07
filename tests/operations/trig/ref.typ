// zcalc.sin / cos / tan with unitless (radian), rad, degree, arcminute and arcsecond angles.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin(0)
  num("0"),
  // 2: sin(1.0 rad)
  num("0.84"),
  // 3: sin(pi/2)
  num("1"),
  // 4: sin(30 deg)
  num("0.50"),
  // 5: sin(30.0 deg)
  num("0.500"),
  // 6: sin(90.0 deg)
  num("1.00"),
  // 7: sin(-30.0 deg)
  num("-0.500"),
  // 8: sin(0.52 rad)
  num("0.50"),
  // 9: sin(1.00 rad)
  num("0.841"),
  // 10: sin(90.0 arcmin)
  num("0.0262"),
  // 11: sin(5400.0 arcsec)
  num("0.026177"),
  // 12: sin(1e5 arcsec) (existing)
  num("0.5"),
  // 13: sin(1.00 rad) with uncertainty
  num("0.841+-0.005"),
  // 14: sin of an unitless number with uncertainty
  num("0.841+-0.005"),
  // 15: sin of a negative number
  num("-0.84"),
  // 16: cos(0.0 rad) ... see bugs
  num("0.54"),
  // 17: cos(60.0 deg)
  num("0.500"),
  // 18: cos(-60.0 deg) is even
  num("0.500"),
  // 19: cos(1.00 rad)
  num("0.540"),
  // 20: cos(3.6e3 arcmin) (existing)
  num("0.50"),
  // 21: cos(2.1e5 arcsec) (existing)
  num("0.52"),
  // 22: cos(pi) of a constant keeps all digits
  num("-1"),
  // 23: cos(1.00 rad) with uncertainty
  num("0.540+-0.008"),
  // 24: tan(0.0)
  num("0"),
  // 25: tan(45.0 deg)
  num("1.00"),
  // 26: tan(-45.0 deg)
  num("-1.00"),
  // 27: tan(0.5 rad) uses exponent notation below 1
  num("5e-1"),
  // 28: tan(89.0 deg)
  num("57.3"),
  // 29: tan(2700.0 arcmin)
  num("1.0000"),
  // 30: tan(1.00 rad) with uncertainty
  num("1.56+-0.03"),
  // 31: tan = sin / cos
  num("5.77e-1"),
  // 32: sin of a sum of angles
  num("0.500"),
  // 33: named arguments
  num("5.00e-1", exponent: "sci"),
  // 34: sin(1.8e3 arcmin)
  num("0.50"),
  // 35: cos(60 deg)
  num("0.50"),
  // 36: cos(1 rad)
  num("0.5"),
)
