// reference: merged sources
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1
  [add 3],
  // 2
  [3],
  // 3
  [4],
  // 4
  [21],
  // 5
  [3],
  // 6
  [21],
  // 7
  [add 2],
  // 8
  [add 2],
  // 9
  [2],
  // 10
  [6],
  // 11
  [#0.173205],
  // 12
  $#num("1.0") + #num("2.0") + #num("3.0")$,
  // 13
  $#num("2.0") dot #num("3.0") dot #num("4.0")$,
  // 14
  $#num("1.0") + #num("2.0") + #num("3.0")$,
  // 15
  $#num("3.0") dot #num("3.0")$,
  // 16
  [2],
  // 17
  $#num("3.0") + #num("3.0")$,
  // 18
  $sqrt((#num("0.1"))^2 + (#num("0.2"))^2 + (#num("0.3"))^2)$,
)
