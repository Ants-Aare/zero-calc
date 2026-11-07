/// [skip]
// BUG: a dimensionless result of unit arithmetic is rendered with a trailing space.
//
// When units cancel (m / m, m * m^-1, m^0) the result keeps an *empty* unit `(numerator: (), denominator: ())`
// instead of none, display-info therefore takes the quantity path and zi.units.qty appends a unit separator.
// The output is 5pt wider than the same number printed with num().
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: m / m
  num("2.0"),
  // 2: m * m^-1
  num("6.0"),
  // 3: m^0
  num("1.0"),
  // 4: (m/s) / (m/s)
  num("2.0"),
  // 5: km / m with convert-si
  num("2.0e3"),
)
