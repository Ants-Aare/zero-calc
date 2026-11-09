// Calculations without a result return the content "undefined" instead of failing.
// Using that content in another calculation is an error (not tested here, it stops the document).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: division by zero
  zcalc.div("1", "0"),
  // 2: 0 / 0
  zcalc.div("0", "0"),
  // 3: division by a result that is zero
  zcalc.div("1", zcalc.sub("1.0", "1.0")),
  // 4: division by a quantity of zero
  zcalc.div(zi.m("1.0"), zi.s("0.0")),
  // 5: 0 / 5 is fine
  zcalc.div("0", "5.0"),
  // 6: tan(90°)
  zcalc.tan(zi.degree("90")),
  // 7: tan(270°)
  zcalc.tan(zi.degree("270")),
  // 8: tan(pi/2)
  zcalc.tan(zcalc.div(zcalc.pi, "2")),
  // 9: tan(89°) is fine
  zcalc.tan(zi.degree("89.0")),
  // 10: asin outside of [-1, 1]
  zcalc.asin("1.5"),
  // 11: acos outside of [-1, 1]
  zcalc.acos("-1.5"),
  // 12: asin(1) has a value
  zcalc.asin("1.0"),
  // 13: asin(1) with uncertainty has an infinite slope
  zcalc.asin("1.0+-0.1"),
  // 14: acos(-1) with uncertainty
  zcalc.acos("-1.0+-0.1"),
  // 15: log of zero
  zcalc.log("0", "10"),
  // 16: log of a negative number
  zcalc.ln("-1"),
  // 17: log with base 1
  zcalc.log("5", "1"),
  // 18: square root of a negative number
  zcalc.sqrt("-4"),
  // 19: odd root of a negative number
  zcalc.root("-8", "3"),
  // 20: even root of a negative number
  zcalc.root("-8", "2"),
  // 21: zeroth root
  zcalc.root("8", "0"),
  // 22: 0^0
  zcalc.pow("0", "0"),
  // 23: 0^-1
  zcalc.pow("0", "-1"),
  // 24: 0^2 is fine
  zcalc.pow("0", "2"),
  // 25: negative base, fractional exponent
  zcalc.pow("-8", "0.5"),
  // 26: negative base, integer exponent
  zcalc.pow("-2", "3"),
  // 27: equations: division by zero
  equation.define($a / b$)(a: 1, b: 0),
  // 28: equations: undefined is passed on to the rest of the equation
  equation.define($a / b + c$)(a: 1, b: 0, c: 2),
  // 29: equations: and through roots
  equation.define($sqrt(a / b)$)(a: 1, b: 0),
  // 30: none still wins over everything
  zcalc.div("1", none),
)
