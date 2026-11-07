/// [skip]
// BUG: arcsin / arccos / arctan inside an equation panic.
//
// The grammar produces the heads `arcsin`/`arccos`/`arctan`, apply-operations only knows `asin`/`acos`/`atan`
// and ends in panic(head). Unit and rounding of the result then follow zcalc.asin/acos/atan.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: arcsin(x)
  check(equation.define($arcsin(x)$)(x: "0.5"), float: 30),
  // 2: arccos(x)
  check(equation.define($arccos(x)$)(x: "0.5"), float: 60),
  // 3: arctan(x)
  check(equation.define($arctan(x)$)(x: "1.0"), float: 45),
)
