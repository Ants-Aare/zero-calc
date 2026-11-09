// zcalc.to-float / zcalc.to-uncertainty: plain floats out of numbers, quantities and results, for single values and arrays.
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: result of an operation
  [#6.0],
  // 2: string with exponent
  [#1500.0],
  // 3: int becomes a float
  [#7.0],
  // 4: negative string
  [#(-2.5)],
  // 5: zero's own number
  [#2.5],
  // 6: quantity: the unit is ignored
  [#3.0],
  // 7: converted into another unit
  [#1500.0],
  // 8: converted into a larger unit
  [#1.5],
  // 9: array of mixed inputs
  [#(1.0, 2.5, 3.0, 3.0)],
  // 10: array converted into another unit
  [#(1000.0, 500.0)],
  // 11: none stays none
  [none],
  // 12: none inside an array
  [#repr((1.0, none))],
  // 13: constants
  [#calc.pi],
  // 14: uncertainty
  [#0.1],
  // 15: no uncertainty
  [none],
  // 16: uncertainty of a result
  [#28.284271],
  // 17: uncertainty array
  [#repr((none, 0.1))],
  // 18: uncertainty converted into another unit
  [#100.0],
  // 19: empty array
  [#repr(())],
)
