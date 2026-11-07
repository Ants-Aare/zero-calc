/// [skip]
// BUG: sin/cos/tan do not convert the uncertainty of an angle given in degrees.
//
// The uncertainty is propagated with the derivative in radians (d sin x = cos x dx), but the
// angle uncertainty is still expressed in degrees (the unit of the input), so it comes out 57x too large.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin(30.0 +- 1.0 deg)
  num("0.500+-0.015"),
  // 2: cos(60.0 +- 1.0 deg)
  num("0.500+-0.015"),
  // 3: tan(45.0 +- 1.0 deg)
  num("1.000+-0.035"),
  // 4: sin(1800.0 +- 60.0 arcmin)
  num("0.500+-0.015"),
)
