// Variables of an equation may be functions (e.g. another equation) that are evaluated with the same variable scope.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: acceleration * time
  check(equation.define($a times t$)(t: zi.s("5"), a: zi.m-s2("2")), float: 10),
  // 2: kinetic energy from a given velocity
  check(equation.define($1/2 m_1 v^2$)(m-1: zi.kg("75.000"), v: zi.m-s("1.0e1")), float: 3750),
  // 3: velocity variable is another equation
  check(equation.define($1/2 m_1 v^2$)(m-1: zi.kg("75.0"), t: zi.s("5.0"), a: zi.m-s2("2.0"), v: equation.define($a times t$)), float: 3750),
)
