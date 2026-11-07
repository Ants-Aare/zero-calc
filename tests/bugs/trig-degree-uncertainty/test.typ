/// [skip]
// BUG: sin/cos/tan do not convert the uncertainty of an angle given in degrees.
//
// The uncertainty is propagated with the derivative in radians (d sin x = cos x dx), but the
// angle uncertainty is still expressed in degrees (the unit of the input), so it comes out 57x too large.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin(30.0 +- 1.0 deg)
  check(zcalc.sin(zi.degree("30.0+-1.0")), float: 0.5, uncertainty: 0.015114994701951816),
  // 2: cos(60.0 +- 1.0 deg)
  check(zcalc.cos(zi.degree("60.0+-1.0")), float: 0.5, uncertainty: 0.015114994701951814),
  // 3: tan(45.0 +- 1.0 deg)
  check(zcalc.tan(zi.degree("45.0+-1.0")), float: 1, uncertainty: 0.034906585039886584),
  // 4: sin(1800.0 +- 60.0 arcmin)
  check(zcalc.sin(zi.arcminute("1800.0+-60.0")), float: 0.5, uncertainty: 0.015114994701951816),
)
