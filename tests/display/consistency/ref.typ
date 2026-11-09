// display.variable and display.error show exactly the digits of the regular display: variable is the full number, `show-error: false` its value, error its uncertainty.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: mul, the regular display
  zi.declare("m s")("6.0+-0.3"),
  // 2: mul, variable is the same
  zi.declare("m s")("6.0+-0.3"),
  // 3: mul, value only
  zi.declare("m s")("6.0"),
  // 4: mul, uncertainty only
  zi.declare("m s")("0.3"),
  // 5: add, the regular display
  num("4.0+-0.1"),
  // 6: add, variable is the same
  num("4.0+-0.1"),
  // 7: add, value only
  num("4.0"),
  // 8: add, uncertainty only
  num("0.1"),
  // 9: exponent argument, the regular display
  zi.declare("m s")("6.0+-0.3", exponent: "sci"),
  // 10: exponent argument, variable is the same
  zi.declare("m s")("6.0+-0.3", exponent: "sci"),
  // 11: exponent argument, value only
  zi.declare("m s")("6.0", exponent: "sci"),
  // 12: exponent argument, uncertainty only
  zi.declare("m s")("0.3", exponent: "sci"),
  // 13: round argument, the regular display
  num("6.00+-0.36"),
  // 14: round argument, variable is the same
  num("6.00+-0.36"),
  // 15: round argument, value only
  num("6.00"),
  // 16: round argument, uncertainty only
  num("0.36"),
  // 17: exact number, variable is the same
  num("4.0"),
  // 18: exact number, show-error: false changes nothing
  num("4.0"),
  // 19: exact number has an uncertainty of zero
  num("0"),
  // 20: exponent notation, the regular display
  num("1.000+-0.004e2"),
  // 21: exponent notation, value only
  num("1.000e2"),
  // 22: exponent notation, uncertainty only
  num("0.004e2"),
  // 23: rounding carry, the regular display
  num("98.0+-1.0"),
  // 24: rounding carry, value only
  num("98.0"),
  // 25: rounding carry, uncertainty only
  num("1.0"),
  // 26: variable of a variable
  zi.declare("m s")("6.0"),
  // 27: the result of variable is a number again
  zi.declare("m s")("12"),
  // 28: the result of error is a number again
  zi.declare("m s")("1.3"),
)
