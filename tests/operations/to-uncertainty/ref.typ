// reference: the uncertainty as a plain float
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1
  [#0.1],
  // 2
  [none],
  // 3
  [#0.1],
  // 4
  [#0.05],
  // 5
  [none],
  // 6
  [none],
  // 7
  [#0.3],
  // 8
  [#0.349],
  // 9
  [#200.0],
  // 10
  [#28.284271],
  // 11
  [#0.223607],
  // 12
  [none],
  // 13
  [none],
  // 14
  [#100.0],
  // 15
  [#0.1],
  // 16
  [#repr((none, 0.5, 0.1, 28.284))],
  // 17
  [#repr((100.0, 5.0))],
  // 18
  [none],
  // 19
  [#repr((none, 0.1))],
  // 20
  [#repr(())],
  // 21
  [#0.2],
)
