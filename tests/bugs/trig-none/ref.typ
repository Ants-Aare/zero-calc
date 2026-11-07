/// [skip]
// BUG: sin/cos/tan/asin/acos/atan crash on `none`, all other operations pass `none` through.
//
// zcalc.add/sub/mul/div/pow/exp/root/sqrt/log/ln/abs/neg/convert-* return `none` for a `none` argument
// (see unit/none-propagation); the six trigonometric functions do not have that guard.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: sin
  "none",
  // 2: cos
  "none",
  // 3: tan
  "none",
  // 4: asin
  "none",
  // 5: acos
  "none",
  // 6: atan
  "none",
)
