// The accuracy of an operand can be given as decimal places or as significant figures, for the value and for the uncertainty.
// Every operation reads both the same way: `same` fails when the places version differs from the figures version.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check, check-round, same
#set page(width: auto, height: auto, margin: .5em)

// 1.234 shown with one decimal place is two significant figures
#let places(x, p) = num(x, round: (mode: "places", precision: p))
#let figures(x, p) = num(x, round: (mode: "figures", precision: p))

#cases(
  // 1: mul, value in places
  same(zcalc.mul(places("1.234", 1), "3.00"), zcalc.mul(figures("1.234", 2), "3.00")),
  // 2: mul, leading zeros after the decimal point do not count
  same(zcalc.mul(places("0.0234", 3), "3.00"), zcalc.mul(figures("0.0234", 2), "3.00")),
  // 3: mul, places finer than the digits of the number
  same(zcalc.mul(places("1.2", 3), "3.00"), zcalc.mul(figures("1.2", 4), "3.00")),
  // 4: div
  same(zcalc.div(places("1.234", 1), "3.00"), zcalc.div(figures("1.234", 2), "3.00")),
  // 5: pow
  same(zcalc.pow(places("1.234", 1), "2"), zcalc.pow(figures("1.234", 2), "2")),
  // 6: sqrt
  same(zcalc.sqrt(places("2.0", 3)), zcalc.sqrt(figures("2.0", 4))),
  // 7: ln
  same(zcalc.ln(places("12.34", 1)), zcalc.ln(figures("12.34", 3))),
  // 8: log
  same(zcalc.log(places("12.34", 1), "10"), zcalc.log(figures("12.34", 3), "10")),
  // 9: sin
  same(zcalc.sin(places("0.5234", 3)), zcalc.sin(figures("0.5234", 3))),
  // 10: asin
  same(zcalc.asin(places("0.5234", 3)), zcalc.asin(figures("0.5234", 3))),
  // 11: add
  same(zcalc.add(places("1.234", 1), "3.00"), zcalc.add(figures("1.234", 2), "3.00")),
  // 12: sub
  same(zcalc.sub("3.00", places("1.234", 1)), zcalc.sub("3.00", figures("1.234", 2))),
  // 13: neg keeps the accuracy of its operand
  zcalc.neg(places("1.234", 1)),
  // 14: without a mode the places of zero's default are used
  same(zcalc.mul(num("1.234", round: (precision: 1)), "3.00"), zcalc.mul(places("1.234", 1), "3.00")),
  // 15: uncertainty in places, mul
  same(
    zcalc.mul(num("1.234+-0.056", round: (uncertainty-precision: (places: 2))), "3.00"),
    zcalc.mul(num("1.234+-0.056", round: (uncertainty-precision: 1)), "3.00"),
  ),
  // 16: uncertainty in places, add
  same(
    zcalc.add(num("1.234+-0.056", round: (uncertainty-precision: (places: 2))), "3.00"),
    zcalc.add(num("1.234+-0.056", round: (uncertainty-precision: 1)), "3.00"),
  ),
  // 17: uncertainty in places finer than its digits
  same(
    zcalc.mul(num("1.2+-0.1", round: (uncertainty-precision: (places: 3))), "3.0"),
    zcalc.mul(num("1.2+-0.1", round: (uncertainty-precision: 3)), "3.0"),
  ),
  // 18: value and uncertainty in places, sqrt
  same(
    zcalc.sqrt(num("2.00+-0.05", round: (mode: "places", precision: 2, uncertainty-precision: (places: 2)))),
    zcalc.sqrt(num("2.00+-0.05", round: (mode: "figures", precision: 3, uncertainty-precision: 1))),
  ),
  // 19: places given at the call site decide how the result is shown
  zcalc.mul("1.234", "3.00", round: (mode: "places", precision: 1)),
  // 20: the accuracy of an operand is not handed on to the result
  check-round(zcalc.mul(places("0.0234", 3), "3.00"), precision: 2),
  // 21: convert-units: the accuracy follows the number
  same(
    zcalc.convert-units(zi.km("1.234", round: (mode: "places", precision: 1)), zi.m),
    zcalc.convert-units(zi.km("1.234", round: (mode: "figures", precision: 2)), zi.m),
  ),
)
