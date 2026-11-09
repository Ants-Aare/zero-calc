// zero's own settings (set-num, set-round, set-group, set-unit) apply to zcalc results, computed precision wins over the global rounding.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)
#let method = display.method.with(show-result: false)
#let error-method = display.error-method.with(show-result: false)

#let reset() = {
  set-num(exponent: auto, product: sym.times, uncertainty-mode: "separate", decimal-separator: ".", positive-sign: false)
  set-round(mode: "places", precision: auto, uncertainty-precision: auto, follow-uncertainty: true, pad: true)
  set-group(size: 3, separator: sym.space.nobreak.narrow, threshold: 5)
  set-unit(fraction: "power", unit-separator: sym.space.nobreak.narrow)
}

#cases(
  // 1: defaults
  zcalc.mul("2.0", "3.00"),
  // 2: scientific exponent
  [#set-num(exponent: "sci") #zcalc.mul("2.0", "3.00")],
  // 3: scientific exponent, large result
  zcalc.mul("1.5e3", "2.0e3"),
  // 4: scientific exponent, add
  zcalc.add("1.5", "2.25"),
  // 5: scientific exponent, quantity with uncertainty
  zcalc.mul(zi.m("2.0+-0.1"), zi.s("3.00+-0.05")),
  // 6: engineering exponent
  [#set-num(exponent: "eng") #zcalc.mul("1.5e4", "2.0")],
  // 7: engineering exponent, uncertainty
  zcalc.mul(zi.m("1.5+-0.1e4"), "2.0"),
  // 8: product symbol
  [#reset() #set-num(product: sym.dot) #zcalc.mul("1.5e3", "2.0e3")],
  // 9: product symbol in the method display
  method(zcalc.mul("2.0", "3.0")),
  // 10: product symbol in the error method display
  error-method(zcalc.mul("2.0+-0.1", "3.0+-0.1")),
  // 11: compact uncertainty
  [#reset() #set-num(uncertainty-mode: "compact") #zcalc.mul(zi.m("2.0+-0.1"), zi.s("3.00+-0.05"))],
  // 12: compact uncertainty, add
  zcalc.add("1.5+-0.1", "2.5+-0.1"),
  // 13: decimal separator
  [#reset() #set-num(decimal-separator: ",") #zcalc.mul("2.0+-0.1", "3.00+-0.05")],
  // 14: decimal separator in the method display
  display.method(zcalc.mul("2.0", "3.0")),
  // 15: positive sign
  [#reset() #set-num(positive-sign: true) #zcalc.mul("2.0", "3.00")],
  // 16: global rounding does not shorten computed results (places)
  [#reset() #set-round(mode: "places", precision: 1) #zcalc.mul("2.00", "3.00")],
  // 17: global rounding does not shorten computed results (add)
  zcalc.add("1.234", "2.345"),
  // 18: global rounding applies to plain numbers
  display.variable("1.2345"),
  // 19: global rounding applies to constants
  zcalc.pi,
  // 20: global figures rounding does not change computed results
  [#reset() #set-round(mode: "figures", precision: 3) #zcalc.add("1.2345", "2.5")],
  // 21: call-site round wins over the global rounding
  zcalc.add("1.2345", "2.5", round: (mode: "places", precision: 3)),
  // 22: trailing zeros are significant, a global pad: false does not remove them
  [#reset() #set-round(pad: false) #zcalc.mul("2.0", "3.00")],
  // 23: digit grouping
  [#reset() #zcalc.add("123456", "2")],
  // 24: custom group separator
  [#set-group(separator: ",") #zcalc.add("123456", "2")],
  // 25: grouping threshold
  [#set-group(threshold: 7) #zcalc.add("123456", "2")],
  // 26: fraction units
  [#reset() #set-unit(fraction: "fraction") #zcalc.div(zi.m("6.0"), zi.s("2.0"))],
  // 27: inline fraction units
  [#set-unit(fraction: "inline") #zcalc.div(zi.m("6.0"), zi.s("2.0"))],
  // 28: unit separator
  [#reset() #set-unit(unit-separator: sym.dot) #zcalc.mul(zi.m("2.0"), zi.s("3.0"))],
  // 29: set-num round: the computed round wins
  [#reset() #set-num(round: (mode: "figures", precision: 1)) #zcalc.mul("2.0", "3.00")],
)
