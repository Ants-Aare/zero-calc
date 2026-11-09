// zero's own settings (set-num, set-round, set-group, set-unit) apply to zcalc results, computed precision wins over the global rounding.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#let reset() = {
  set-num(exponent: auto, product: sym.times, uncertainty-mode: "separate", decimal-separator: ".", positive-sign: false)
  set-round(mode: "places", precision: auto, uncertainty-precision: auto, follow-uncertainty: true, pad: true)
  set-group(size: 3, separator: sym.space.nobreak.narrow, threshold: 5)
  set-unit(fraction: "power", unit-separator: sym.space.nobreak.narrow)
}

#cases(
  // 1: defaults
  num("6.0"),
  // 2: scientific exponent
  [#set-num(exponent: "sci") #num("6.0")],
  // 3: scientific exponent, large result
  num("3.0e6"),
  // 4: scientific exponent, add
  num("3.8"),
  // 5: scientific exponent, quantity with uncertainty
  zi.declare("m s")("6.0+-0.3"),
  // 6: engineering exponent
  [#set-num(exponent: "eng") #num("3.0e4")],
  // 7: engineering exponent, uncertainty
  zi.m("3.0+-0.2e4"),
  // 8: product symbol
  [#reset() #set-num(product: sym.dot) #num("3.0e6")],
  // 9: product symbol in the method display
  $#num("2.0") dot #num("3.0")$,
  // 10: product symbol in the error method display
  $#num("6.0") dot sqrt((#num("0.1")/#num("2.0"))^2 + (#num("0.1")/#num("3.0"))^2)$,
  // 11: compact uncertainty
  [#reset() #set-num(uncertainty-mode: "compact") #zi.declare("m s")("6.0+-0.3")],
  // 12: compact uncertainty, add
  num("4.0+-0.1"),
  // 13: decimal separator
  [#reset() #set-num(decimal-separator: ",") #num("6.0+-0.3")],
  // 14: decimal separator in the method display
  math.equation($ #num("2,0") times #num("3,0") = #num("6,0") $),
  // 15: positive sign
  [#reset() #set-num(positive-sign: true) #num("6.0")],
  // 16: global rounding does not shorten computed results (places)
  [#reset() #set-round(mode: "places", precision: 1) #num("6.00", round: (precision: 2))],
  // 17: global rounding does not shorten computed results (add)
  num("3.579", round: (precision: 3)),
  // 18: global rounding applies to plain numbers
  num("1.2345"),
  // 19: global rounding applies to constants
  num(calc.pi),
  // 20: global figures rounding does not change computed results
  [#reset() #set-round(mode: "figures", precision: 3) #num("3.7", round: (mode: "places", precision: 1))],
  // 21: call-site round wins over the global rounding
  num("3.735", round: (mode: "places", precision: 3)),
  // 22: padding
  [#reset() #set-round(pad: false) #num("6.0")],
  // 23: digit grouping
  [#reset() #num("123458")],
  // 24: custom group separator
  [#set-group(separator: ",") #num("123458")],
  // 25: grouping threshold
  [#set-group(threshold: 7) #num("123458")],
  // 26: fraction units
  [#reset() #set-unit(fraction: "fraction") #zi.declare("m/s")("3.0")],
  // 27: inline fraction units
  [#set-unit(fraction: "inline") #zi.declare("m/s")("3.0")],
  // 28: unit separator
  [#reset() #set-unit(unit-separator: sym.dot) #zi.declare("m s")("6.0")],
  // 29: set-num round: the computed round wins
  [#reset() #set-num(round: (mode: "figures", precision: 1)) #num("6.0", round: (mode: "figures", precision: 2))],
)
