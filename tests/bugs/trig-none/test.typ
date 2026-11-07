/// [skip]
// BUG: sin/cos/tan/asin/acos/atan crash on `none`, all other operations pass `none` through.
//
// zcalc.add/sub/mul/div/pow/exp/root/sqrt/log/ln/abs/neg/convert-* return `none` for a `none` argument
// (see unit/none-propagation); the six trigonometric functions do not have that guard.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin
  repr(zcalc.sin(none)),
  // 2: cos
  repr(zcalc.cos(none)),
  // 3: tan
  repr(zcalc.tan(none)),
  // 4: asin
  repr(zcalc.asin(none)),
  // 5: acos
  repr(zcalc.acos(none)),
  // 6: atan
  repr(zcalc.atan(none)),
)
