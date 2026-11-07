// zcalc.asin / acos / atan. Results carry a unit (degree by default, or rad, arcminute, arcsecond).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: asin(0.5)
  check(zcalc.asin("0.5"), float: 30),
  // 2: asin(1.0)
  check(zcalc.asin("1.0"), float: 90),
  // 3: asin(-1.0)
  check(zcalc.asin("-1.0"), float: -90),
  // 4: asin(0.0)
  check(zcalc.asin("0.0"), float: 0),
  // 5: asin(0.50)
  check(zcalc.asin("0.50"), float: 30),
  // 6: asin in rad
  check(zcalc.asin("0.5", unit: "rad"), float: 0.5235987755982988),
  // 7: asin in arcminutes
  check(zcalc.asin("0.5", unit: sym.prime), float: 1800),
  // 8: acos(0.5)
  check(zcalc.acos("0.5"), float: 60),
  // 9: acos(1.0)
  check(zcalc.acos("1.0"), float: 0),
  // 10: acos(-1.0)
  check(zcalc.acos("-1.0"), float: 180),
  // 11: acos(0.50) in rad
  check(zcalc.acos("0.50", unit: "rad"), float: 1.0471975511965976),
  // 12: acos in arcminutes
  check(zcalc.acos("0.5", unit: sym.prime), float: 3600),
  // 13: atan(1.0)
  check(zcalc.atan("1.0"), float: 45),
  // 14: atan(-1.0)
  check(zcalc.atan("-1.0"), float: -45),
  // 15: atan(0.0)
  check(zcalc.atan("0.0"), float: 0),
  // 16: atan(1.0e10) approaches 90
  check(zcalc.atan("1.0e10"), float: 89.99999999427042),
  // 17: atan(1.0) in rad
  check(zcalc.atan("1.0", unit: "rad"), float: 0.7853981633974483),
  // 18: atan(1.0) in arcminutes
  check(zcalc.atan("1.0", unit: sym.prime), float: 2700),
  // 19: asin(0.50 +- 0.01) in rad
  check(zcalc.asin("0.50+-0.01", unit: "rad"), float: 0.5235987755982988, uncertainty: 0.011547005383792516),
  // 20: acos(0.50 +- 0.01) in rad
  check(zcalc.acos("0.50+-0.01", unit: "rad"), float: 1.0471975511965976, uncertainty: 0.011547005383792516),
  // 21: atan(1.00 +- 0.01) in rad
  check(zcalc.atan("1.00+-0.01", unit: "rad"), float: 0.7853981633974483, uncertainty: 0.005),
  // 22: asin of a negative value with uncertainty
  check(zcalc.asin("-0.50+-0.01", unit: "rad"), float: -0.5235987755982988, uncertainty: 0.011547005383792516),
  // 23: sin(asin(x)) round trip
  check(zcalc.sin(zcalc.asin("0.5")), float: 0.5),
  // 24: cos(acos(x)) round trip
  check(zcalc.cos(zcalc.acos("0.5")), float: 0.5),
  // 25: tan(atan(x)) round trip
  check(zcalc.tan(zcalc.atan("1.0")), float: 1),
  // 26: atan of a quotient (angle of a vector)
  check(zcalc.atan(zcalc.div("3.0", "4.0")), float: 36.86989764584402),
  // 27: atan(0.5)
  check(zcalc.atan("0.5"), float: 26.56505117707799),
  // 28: asin(0.5) in arcseconds
  check(zcalc.asin("0.5", unit: sym.prime.double), float: 108000),
  // 29: acos(0.5) in arcseconds
  check(zcalc.acos("0.5", unit: sym.prime.double), float: 216000),
  // 30: atan(1.0) in arcseconds
  check(zcalc.atan("1.0", unit: sym.prime.double), float: 162000),
  // 31: acos(0.0)
  check(zcalc.acos("0.0"), float: 90),
  // 32: acos(0)
  check(zcalc.acos("0"), float: 90),
  // 33: asin(0.50 +- 0.01)
  check(zcalc.asin("0.50+-0.01"), float: 30, uncertainty: 0.6615946745061505),
  // 34: acos(0.50 +- 0.01)
  check(zcalc.acos("0.50+-0.01"), float: 60, uncertainty: 0.6615946745061505),
  // 35: atan(1.00 +- 0.01)
  check(zcalc.atan("1.00+-0.01"), float: 45, uncertainty: 0.2864788975654116),
  // 36: asin(0.50 +- 0.01) in arcminutes
  check(zcalc.asin("0.50+-0.01", unit: sym.prime), float: 1800, uncertainty: 39.69568047036903),
)
