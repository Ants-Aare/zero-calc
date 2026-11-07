// display.error: the uncertainty of a value on its own.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: uncertainty of a sum
  num("0.1"),
  // 2: uncertainty with unit
  zi.declare("m s")("0.4"),
  // 3: no uncertainty is zero
  num("0"),
  // 4: uncertainty of an input keeps its digits
  num("0.123"),
  // 5: uncertainty in exponent notation
  num("0.004e2"),
)
