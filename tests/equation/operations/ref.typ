// equation.define: every supported math construct maps to the matching zcalc operation.
// Numbers written inside the equation are constants and never limit the precision.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: a + b
  num("8"),
  // 2: a - b
  num("2"),
  // 3: unary minus
  num("-5"),
  // 4: unary plus
  num("5"),
  // 5: a times b
  num("20"),
  // 6: a dot b
  num("20"),
  // 7: implicit multiplication
  num("20"),
  // 8: three factors
  num("30"),
  // 9: grouping
  num("30"),
  // 10: fraction
  num("2"),
  // 11: abs()
  num("6"),
  // 12: |a|
  num("6"),
  // 13: a^b
  num("36"),
  // 14: a^2 (exact exponent)
  num("36"),
  // 15: root(index, radicand)
  num("3.0"),
  // 16: root with a literal index
  num("3.0"),
  // 17: sqrt
  num("6.0"),
  // 18: sqrt of a sum of squares
  num("5.0"),
  // 19: f(x) is the variable `f-x`
  num("5"),
  // 20: ln x
  num("1"),
  // 21: ln(x)
  num("1"),
  // 22: ln(e) is exact
  num("1"),
  // 23: ln e is exact
  num("1"),
  // 24: log x is base 10
  num("2.00"),
  // 25: log_5 x
  num("2.0"),
  // 26: log(x)
  num("2.00"),
  // 27: log_5(x)
  num("2.0"),
  // 28: log_b(x) with a variable base
  num("2"),
  // 29: sin(x)
  num("1.0"),
  // 30: sin(pi/2) is exact
  num("1"),
  // 31: cos(x)
  num("1"),
  // 32: cos(2 pi) is exact
  num("1"),
  // 33: tan(x)
  num("2"),
  // 34: delta d / delta t with units
  zi.declare("m/s")("4"),
  // 35: Delta H is the variable `Delta-H`
  num("5"),
  // 36: delta x is the variable `delta-x`
  num("5.0"),
  // 37: subscripts: x_1 + x_2
  num("4.0"),
  // 38: uncertainties are propagated
  num("8.0+-0.2"),
  // 39: uncertainty of a power
  num("9.0+-0.6"),
  // 40: literal factor is a constant
  num("10"),
  // 41: literal fraction is a constant
  num("2.5"),
  // 42: literal decimal is a constant
  num("2.5"),
  // 43: pi and e are known symbols
  num("13"),
)
