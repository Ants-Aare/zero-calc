// reference: flags of undefined and infinite results
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1
  [#repr((undefined: "-", infinite: "-"))],
  // 2
  [#repr((undefined: true, infinite: "-"))],
  // 3
  [#repr((undefined: true, infinite: "-"))],
  // 4
  [#repr((undefined: "-", infinite: true))],
  // 5
  [-],
  // 6
  [#repr((undefined: "-", infinite: true))],
  // 7
  [#repr((undefined: "-", infinite: "-"))],
  // 8
  [#repr("div")],
  // 9
  [1,0],
  // 10
  $#num("1") / #num("0")$,
  // 11
  math.equation($ #num("1") / #num("0") = "undefined" $),
  // 12
  math.equation($ #num("1e300") times #num("1e300") = #num(calc.inf) $),
  // 13
  [undefined],
  // 14
  [undefined],
  // 15
  math.equation($ 0 = "undefined" $),
  // 16
  [#repr((undefined: true, infinite: "-"))],
  // 17
  $#num("1") / #num("0") + #num("2")$,
  // 18
  [#repr((undefined: true, infinite: "-"))],
  // 19
  num("2.5e-1"),
)
