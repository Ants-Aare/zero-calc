// zcalc.to-uncertainty: the uncertainty as a plain float, from numbers, quantities and results, for single values and arrays.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: quantity
  [#zcalc.to-uncertainty(zi.m("3.0+-0.1"))],
  // 2: number without uncertainty
  [#repr(zcalc.to-uncertainty("3.0"))],
  // 3: string with uncertainty
  [#zcalc.to-uncertainty("3.0+-0.1")],
  // 4: string with the uncertainty in brackets
  [#zcalc.to-uncertainty("3.00(5)")],
  // 5: int has none
  [#repr(zcalc.to-uncertainty(7))],
  // 6: float has none
  [#repr(zcalc.to-uncertainty(7.5))],
  // 7: zero's own number
  [#zcalc.to-uncertainty(num("2.5+-0.3"))],
  // 8: the uncertainty is not rounded with the shown digits
  [#zcalc.to-uncertainty(num("2.5+-0.349"))],
  // 9: uncertainty with an exponent
  [#zcalc.to-uncertainty("1.5(2)e3")],
  // 10: result of a product
  [#calc.round(zcalc.to-uncertainty(zcalc.mul("10+-1", "20+-2")), digits: 6)],
  // 11: result of a sum
  [#calc.round(zcalc.to-uncertainty(zcalc.add("1.0+-0.1", "2.0+-0.2")), digits: 6)],
  // 12: result without uncertainty
  [#repr(zcalc.to-uncertainty(zcalc.mul("2.0", "3.0")))],
  // 13: constants have none
  [#repr(zcalc.to-uncertainty(zcalc.pi))],
  // 14: converted into another unit
  [#zcalc.to-uncertainty(zi.km("3.0+-0.1"), unit: zi.m)],
  // 15: converted into a larger unit
  [#zcalc.to-uncertainty(zi.m("3000+-100"), unit: zi.km)],
  // 16: array of mixed inputs
  [#repr(zcalc.to-uncertainty((1, "2.0+-0.5", zi.m("3.0+-0.1"), zcalc.mul("10+-1", "20+-2"))).map(x => if x == none { none } else { calc.round(x, digits: 3) }))],
  // 17: array converted into another unit
  [#repr(zcalc.to-uncertainty((zi.km("1.0+-0.1"), zi.m("500+-5")), unit: zi.m))],
  // 18: none stays none
  [#repr(zcalc.to-uncertainty(none))],
  // 19: none inside an array
  [#repr(zcalc.to-uncertainty((none, "1.0+-0.1")))],
  // 20: empty array
  [#repr(zcalc.to-uncertainty(()))],
  // 21: negative number with uncertainty
  [#zcalc.to-uncertainty("-4.0+-0.2")],
)
