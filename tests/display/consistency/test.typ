// display.variable and display.error show exactly the digits of the regular display: variable is the full number, `show-error: false` its value, error its uncertainty.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#let mul = zcalc.mul(zi.m("2.0+-0.1"), zi.s("3.00+-0.05"))
#let add = zcalc.add("1.5+-0.1", "2.5+-0.1")
#let sci = zcalc.mul(zi.m("2.0+-0.1", exponent: "sci"), zi.s("3.00+-0.05"))
#let places = zcalc.mul("2.0+-0.1", "3.0+-0.1", round: (mode: "places", precision: 3, uncertainty-precision: (places: 2)))
#let plain = zcalc.add("1.5", "2.5")
#let wide = zcalc.mul("5.00+-0.02e-1", "2.0e2")
#let carry = zcalc.mul("9.9+-0.1", "9.9")

#cases(
  // 1: mul, the regular display
  mul,
  // 2: mul, variable is the same
  display.variable(mul),
  // 3: mul, value only
  display.variable(mul, show-error: false),
  // 4: mul, uncertainty only
  display.error(mul),
  // 5: add, the regular display
  add,
  // 6: add, variable is the same
  display.variable(add),
  // 7: add, value only
  display.variable(add, show-error: false),
  // 8: add, uncertainty only
  display.error(add),
  // 9: exponent argument, the regular display
  sci,
  // 10: exponent argument, variable is the same
  display.variable(sci),
  // 11: exponent argument, value only
  display.variable(sci, show-error: false),
  // 12: exponent argument, uncertainty only
  display.error(sci),
  // 13: round argument, the regular display
  places,
  // 14: round argument, variable is the same
  display.variable(places),
  // 15: round argument, value only
  display.variable(places, show-error: false),
  // 16: round argument, uncertainty only
  display.error(places),
  // 17: exact number, variable is the same
  display.variable(plain),
  // 18: exact number, show-error: false changes nothing
  display.variable(plain, show-error: false),
  // 19: exact number has an uncertainty of zero
  display.error(plain),
  // 20: exponent notation, the regular display
  wide,
  // 21: exponent notation, value only
  display.variable(wide, show-error: false),
  // 22: exponent notation, uncertainty only
  display.error(wide),
  // 23: rounding carry, the regular display
  carry,
  // 24: rounding carry, value only
  display.variable(carry, show-error: false),
  // 25: rounding carry, uncertainty only
  display.error(carry),
  // 26: variable of a variable
  display.variable(display.variable(mul, show-error: false)),
  // 27: the result of variable is a number again
  check(zcalc.mul(display.variable(mul, show-error: false), "2.0"), float: 12),
  // 28: the result of error is a number again (with its unrounded value)
  check(zcalc.add(display.error(mul), "1.0"), float: 1.31622776601684),
)
