// equation.define: every supported math construct maps to the matching zcalc operation.
// Numbers written inside the equation are constants and never limit the precision.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: a + b
  equation.define($a + b$)(a: 5, b: 3),
  // 2: a - b
  equation.define($a - b$)(a: 5, b: 3),
  // 3: unary minus
  equation.define($-a$)(a: 5),
  // 4: unary plus
  equation.define($+a$)(a: 5),
  // 5: a times b
  check(equation.define($a times b$)(a: 5, b: 3), float: 15),
  // 6: a dot b
  check(equation.define($a dot b$)(a: 5, b: 3), float: 15),
  // 7: implicit multiplication
  check(equation.define($a b$)(a: 5, b: 3), float: 15),
  // 8: three factors
  check(equation.define($a b c$)(a: 5, b: 3, c: 2), float: 30),
  // 9: grouping
  check(equation.define($a (b + c)$)(a: "5", b: "3", c: "2"), float: 25),
  // 10: fraction
  check(equation.define($a / b$)(a: 6, b: 3), float: 2),
  // 11: abs()
  equation.define($abs(a)$)(a: -6),
  // 12: |a|
  equation.define($|a|$)(a: 6),
  // 13: a^b
  check(equation.define($a^b$)(a: "6.0", b: "2.0"), float: 36),
  // 14: a^2 (exact exponent)
  check(equation.define($a^2$)(a: "6.0"), float: 36),
  // 15: root(index, radicand)
  check(equation.define($root(b, a)$)(a: "27", b: 3), float: 3),
  // 16: root with a literal index
  check(equation.define($root(3, a)$)(a: "27"), float: 3),
  // 17: sqrt
  check(equation.define($sqrt(a)$)(a: "36"), float: 6),
  // 18: sqrt of a sum of squares
  check(equation.define($sqrt(a^2 + b^2)$)(a: "3.0", b: "4.0"), float: 5),
  // 19: f(x) is the variable `f-x`
  equation.define($f(x)$)(f-x: 5),
  // 20: ln x
  check(equation.define($ln x$)(x: 3), float: 1.0986122886681098),
  // 21: ln(x)
  check(equation.define($ln(x)$)(x: 3), float: 1.0986122886681098),
  // 22: ln(e) is exact
  equation.define($ln(e)$)(),
  // 23: ln e is exact
  equation.define($ln e$)(),
  // 24: log x is base 10
  check(equation.define($log x$)(x: 100), float: 2),
  // 25: log_5 x
  check(equation.define($log_5 x$)(x: 25), float: 2),
  // 26: log(x)
  check(equation.define($log(x)$)(x: 100), float: 2),
  // 27: log_5(x)
  check(equation.define($log_5(x)$)(x: 25), float: 2),
  // 28: log_b(x) with a variable base
  check(equation.define($log_b (x)$)(x: 25, b: 5), float: 2),
  // 29: sin(x)
  check(equation.define($sin(x)$)(x: 1.6), float: 0.9995736030415051),
  // 30: sin(pi/2) is exact
  equation.define($sin(pi/2)$)(),
  // 31: cos(x)
  check(equation.define($cos(x)$)(x: 6), float: 0.960170286650366),
  // 32: cos(2 pi) is exact
  equation.define($cos(2pi)$)(),
  // 33: tan(x)
  check(equation.define($tan(x)$)(x: 1), float: 1.557407724654902),
  // 34: delta d / delta t with units
  check(equation.define($(delta d)/(delta t)$)(delta-t: zi.second(5), delta-d: zi.meter(20)), float: 4),
  // 35: Delta H is the variable `Delta-H`
  equation.define($Delta H$)(Delta-H: 5),
  // 36: delta x is the variable `delta-x`
  equation.define($delta x$)(delta-x: "5.0"),
  // 37: subscripts: x_1 + x_2
  check(equation.define($x_1 + x_2$)(x-1: "1.5", x-2: "2.5"), float: 4),
  // 38: uncertainties are propagated
  check(equation.define($a + b$)(a: "5.0+-0.1", b: "3.0+-0.2"), float: 8, uncertainty: 0.223606797749979),
  // 39: uncertainty of a power
  check(equation.define($a^2$)(a: "3.0+-0.1"), float: 9, uncertainty: 0.6),
  // 40: literal factor is a constant
  check(equation.define($2 a$)(a: "5.0"), float: 10),
  // 41: literal fraction is a constant
  check(equation.define($1/2 a$)(a: "5.0"), float: 2.5),
  // 42: literal decimal is a constant
  check(equation.define($0.5 a$)(a: "5.0"), float: 2.5),
  // 43: pi and e are known symbols
  check(equation.define($pi r^2$)(r: "2.0"), float: 4*calc.pi),
  // 44: arcsin(x)
  check(equation.define($arcsin(x)$)(x: "0.5"), float: 30),
  // 45: arccos(x)
  check(equation.define($arccos(x)$)(x: "0.5"), float: 60),
  // 46: arctan(x)
  check(equation.define($arctan(x)$)(x: "1.0"), float: 45),
)
