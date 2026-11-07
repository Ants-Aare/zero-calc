// zcalc.asin / acos / atan. Results carry a unit (degree by default, or rad, arcminute, arcsecond).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: asin(0.5)
  zi.degree("30"),
  // 2: asin(1.0)
  zi.degree("90"),
  // 3: asin(-1.0)
  zi.degree("-90"),
  // 4: asin(0.0)
  zi.degree("0"),
  // 5: asin(0.50)
  zi.degree("30"),
  // 6: asin in rad
  zi.rad("5e-1"),
  // 7: asin in arcminutes
  zi.arcminute("2e3"),
  // 8: acos(0.5)
  zi.degree("60"),
  // 9: acos(1.0)
  zi.degree("0"),
  // 10: acos(-1.0)
  zi.degree("1.8e2"),
  // 11: acos(0.50) in rad
  zi.rad("1.0"),
  // 12: acos in arcminutes
  zi.arcminute("4e3"),
  // 13: atan(1.0)
  zi.degree("45"),
  // 14: atan(-1.0)
  zi.degree("-45"),
  // 15: atan(0.0)
  zi.degree("0"),
  // 16: atan(1.0e10) approaches 90
  zi.degree("90"),
  // 17: atan(1.0) in rad
  zi.rad("7.9e-1"),
  // 18: atan(1.0) in arcminutes
  zi.arcminute("2.7e3"),
  // 19: asin(0.50 +- 0.01) in rad
  zi.rad("5.2+-0.1e-1"),
  // 20: acos(0.50 +- 0.01) in rad
  zi.rad("1.05+-0.01"),
  // 21: atan(1.00 +- 0.01) in rad
  zi.rad("7.85+-0.05e-1"),
  // 22: asin of a negative value with uncertainty
  zi.rad("-5.2+-0.1e-1"),
  // 23: sin(asin(x)) round trip
  num("0.5"),
  // 24: cos(acos(x)) round trip
  num("0.5"),
  // 25: tan(atan(x)) round trip
  num("1.0"),
  // 26: atan of a quotient (angle of a vector)
  zi.degree("37"),
  // 27: atan(0.5)
  zi.degree("30"),
)
