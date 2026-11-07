/// [skip]
// BUG: asin/acos/atan return the uncertainty in radians although the value is in degrees (or arcminutes).
//
// The value is divided by the angle unit (1deg), the uncertainty is not, so `0.50 +- 0.01` gives
// `30.00 +- 0.01 deg` instead of `30.0 +- 0.7 deg`.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: asin(0.50 +- 0.01)
  check(zcalc.asin("0.50+-0.01"), float: 30, uncertainty: 0.6615946745061505),
  // 2: acos(0.50 +- 0.01)
  check(zcalc.acos("0.50+-0.01"), float: 60, uncertainty: 0.6615946745061505),
  // 3: atan(1.00 +- 0.01)
  check(zcalc.atan("1.00+-0.01"), float: 45, uncertainty: 0.2864788975654116),
  // 4: asin(0.50 +- 0.01) in arcminutes
  check(zcalc.asin("0.50+-0.01", unit: sym.prime), float: 1800, uncertainty: 39.69568047036903),
)
