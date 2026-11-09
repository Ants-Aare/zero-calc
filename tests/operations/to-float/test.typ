// zcalc.to-float / zcalc.to-uncertainty: plain floats out of numbers, quantities and results, for single values and arrays.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: result of an operation
  [#zcalc.to-float(zcalc.mul("2.0", "3.0"))],
  // 2: string with exponent
  [#zcalc.to-float("1.5e3")],
  // 3: int becomes a float
  [#zcalc.to-float(7)],
  // 4: negative string
  [#zcalc.to-float("-2.5")],
  // 5: zero's own number
  [#zcalc.to-float(num("2.5"))],
  // 6: quantity: the unit is ignored
  [#zcalc.to-float(zi.m("3.0+-0.1"))],
  // 7: converted into another unit
  [#zcalc.to-float(zi.km("1.5"), unit: zi.m)],
  // 8: converted into a larger unit
  [#zcalc.to-float(zi.m("1500"), unit: zi.km)],
  // 9: array of mixed inputs
  [#zcalc.to-float((1, "2.5", zi.m("3.0+-0.1"), zcalc.add("1.0", "2.0")))],
  // 10: array converted into another unit
  [#zcalc.to-float((zi.km("1.0"), zi.m("500")), unit: zi.m)],
  // 11: none stays none
  [#repr(zcalc.to-float(none))],
  // 12: none inside an array
  [#repr(zcalc.to-float((1, none)))],
  // 13: constants
  [#zcalc.to-float(zcalc.pi)],
  // 14: uncertainty
  [#zcalc.to-uncertainty(zi.m("3.0+-0.1"))],
  // 15: no uncertainty
  [#repr(zcalc.to-uncertainty("3.0"))],
  // 16: uncertainty of a result
  [#calc.round(zcalc.to-uncertainty(zcalc.mul("10+-1", "20+-2")), digits: 6)],
  // 17: uncertainty array
  [#repr(zcalc.to-uncertainty((1, zi.m("3.0+-0.1"))))],
  // 18: uncertainty converted into another unit
  [#zcalc.to-uncertainty(zi.km("3.0+-0.1"), unit: zi.m)],
  // 19: empty array
  [#repr(zcalc.to-float(()))],
)
