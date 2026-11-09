// Options of the display functions: product, fraction, show-units, exponential and equals.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)
#let method = display.method.with(show-result: false)
#let error-method = display.error-method.with(show-result: false)

#cases(
  // 1: product symbol
  method(zcalc.mul("2.0", "3.0"), product: sym.dot),
  // 2: no product symbol
  method(zcalc.mul("2.0", "3.0"), product: none),
  // 3: product symbol applies to all factors
  method(zcalc.mul("2.0", "3.0", "4.0"), product: sym.dot),
  // 4: product symbol in nested products
  method(zcalc.add(zcalc.mul("2.0", "3.0"), "1.0"), product: sym.dot),
  // 5: inline fraction
  method(zcalc.div("6.0", "3.0"), fraction: "inline"),
  // 6: inline fraction: parentheses around sums
  method(zcalc.div(zcalc.add("1.0", "2.0"), zcalc.add("3.0", "4.0")), fraction: "inline"),
  // 7: inline fraction: parentheses around the product in the denominator
  method(zcalc.div("6.0", zcalc.mul("3.0", "2.0")), fraction: "inline"),
  // 8: inline fraction: parentheses around the quotient in the denominator
  method(zcalc.div("6.0", zcalc.div("3.0", "2.0")), fraction: "inline"),
  // 9: inline fraction: a product in the numerator needs none
  method(zcalc.div(zcalc.mul("6.0", "3.0"), "2.0"), fraction: "inline"),
  // 10: units hidden
  method(zcalc.mul(zi.m("2.0"), zi.s("3.0")), show-units: false),
  // 11: units hidden in the result of method-result stay
  display.method(zcalc.mul(zi.m("2.0"), zi.s("3.0")), show-units: false),
  // 12: exp as a function
  method(zcalc.exp("2.0"), exponential: "function"),
  // 13: exp as a power
  method(zcalc.exp("2.0"), exponential: "power"),
  // 14: equals symbol of method-result
  display.method(zcalc.add("1.5", "2.25"), equals: sym.approx),
  // 15: options of method-result
  display.method(zcalc.div(zcalc.mul("2.0", "3.0"), "4.0"), product: sym.dot, fraction: "inline"),
  // 16: equation arguments of method-result
  display.method(zcalc.add("1.5", "2.25"), numbering: "(1)"),
  // 17: depth with options
  method(zcalc.mul(zcalc.mul("2.0", "3.0"), "4.0"), depth: 1, product: sym.dot),
  // 18: error-method product symbol
  error-method(zcalc.mul("2.0+-0.1", "3.0+-0.1"), product: sym.dot),
  // 19: error-method without product symbol
  error-method(zcalc.pow("3.0+-0.1", "2"), product: none),
  // 20: error-method without units
  error-method(zcalc.mul(zi.m("2.0+-0.1"), zi.s("3.0")), show-units: false),
  // 21: error-method-result options
  display.error-method(zcalc.mul("2.0+-0.1", "3.0"), product: sym.dot, equals: sym.approx),
  // 22: error-method of a sum counts equal errors
  error-method(zcalc.add("1.0+-0.1", "2.0+-0.1"), product: sym.dot),
  // 23: errors of the operands are shown
  method(zcalc.mul("2.0+-0.1", "3.0+-0.1"), show-error: true, product: sym.dot),
  // 24: frozen expands every level, whatever the depth
  method(zcalc.mul(zcalc.add("1.0", "2.0"), "4.0"), depth: 0, frozen: true),
  // 25: error-method follows the same frozen rules
  error-method(zcalc.mul(zcalc.add("1.0+-0.1", "2.0+-0.1"), "4.0"), depth: 0, frozen: true),
  // 26: without frozen a depth of 0 expands nothing
  error-method(zcalc.mul(zcalc.add("1.0+-0.1", "2.0+-0.1"), "4.0"), depth: 0),
  // 27: show-result: false returns only the calculation
  method(zcalc.add("1.5", "2.25")),
)
