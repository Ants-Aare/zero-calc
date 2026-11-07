/// [skip]
// BUG: asin/acos/atan return the uncertainty in radians although the value is in degrees (or arcminutes).
//
// The value is divided by the angle unit (1deg), the uncertainty is not, so `0.50 +- 0.01` gives
// `30.00 +- 0.01 deg` instead of `30.0 +- 0.7 deg`.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: asin(0.50 +- 0.01)
  zi.degree("30.0+-0.7"),
  // 2: acos(0.50 +- 0.01)
  zi.degree("60.0+-0.7"),
  // 3: atan(1.00 +- 0.01)
  zi.degree("45.0+-0.3"),
  // 4: asin(0.50 +- 0.01) in arcminutes
  zi.arcminute("1800+-40"),
)
