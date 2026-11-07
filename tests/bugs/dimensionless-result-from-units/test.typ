/// [skip]
// BUG: a dimensionless result of unit arithmetic is rendered with a trailing space.
//
// When units cancel (m / m, m * m^-1, m^0) the result keeps an *empty* unit `(numerator: (), denominator: ())`
// instead of none, display-info therefore takes the quantity path and zi.units.qty appends a unit separator.
// The output is 5pt wider than the same number printed with num().
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: m / m
  zcalc.div(zi.m("6.0"), zi.m("3.0")),
  // 2: m * m^-1
  zcalc.mul(zi.m("2.0"), zi.declare("m^-1")("3.0")),
  // 3: m^0
  zcalc.pow(zi.m("3.0"), "0"),
  // 4: (m/s) / (m/s)
  zcalc.div(zi.declare("m/s")("6.0"), zi.declare("m/s")("3.0")),
  // 5: km / m with convert-si
  zcalc.div(zi.km("6.0"), zi.m("3.0"), convert-si: true),
)
