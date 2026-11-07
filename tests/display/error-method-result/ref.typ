// display.error-method-result: `error calculation = error` as one equation.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  math.equation($ sqrt((#num("0.1"))^2 + (#num("0.2"))^2) = #num("0.2") $),
  // 2: mul
  math.equation($ #num("6") times sqrt((#num("0.1")/#num("2.0"))^2 + (#num("0.1")/#num("3.0"))^2) = #num("0.4") $),
  // 3: quantity
  math.equation($ #zi.declare("m/s")("6") times sqrt((#zi.m("0.3")/#zi.m("30"))^2 + (#zi.s("0.4")/#zi.s("5"))^2) = #zi.declare("m/s")("0.5") $),
  // 4: error-method-result of sub
  math.equation($ sqrt((#num("0.1"))^2 + (#num("0.2"))^2) = #num("0.2") $),
)
