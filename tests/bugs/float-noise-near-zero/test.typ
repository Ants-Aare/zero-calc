/// [skip]
// BUG: results that are zero up to floating point noise are printed with all their noise digits.
//
// sin(180 deg) is 1.2e-16 in floating point and is shown as `0.000 000 000 000 000 122 5`.
// Same for cos(90 deg), sin(360 deg), sin(2*pi). Expected: `0` (like sin(0.0), which already prints `0`).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin(180.0 deg)
  check(zcalc.sin(zi.degree("180.0")), float: 0),
  // 2: sin(360.0 deg)
  check(zcalc.sin(zi.degree("360.0")), float: 0),
  // 3: cos(90.0 deg)
  check(zcalc.cos(zi.degree("90.0")), float: 0),
  // 4: cos(270.0 deg)
  check(zcalc.cos(zi.degree("270.0")), float: 0),
  // 5: sin(2.0 * pi)
  check(zcalc.sin(zcalc.mul("2.0", zcalc.pi)), float: 0),
  // 6: tan(180.0 deg)
  check(zcalc.tan(zi.degree("180.0")), float: 0),
  // 7: cos(pi/2) with a plain angle
  check(zcalc.cos(zcalc.div(zcalc.pi, "2")), float: 0),
)
