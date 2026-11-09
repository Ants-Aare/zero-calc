// display.error-method: how the uncertainty was propagated (root of the sum of squares of the partial errors).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)
#let error-method = display.error-method.with(show-result: false)

#cases(
  // 1: add: equal uncertainties are counted
  error-method(zcalc.add("1.5+-0.1", "2.5+-0.1")),
  // 2: add: different uncertainties
  error-method(zcalc.add("1.5+-0.1", "2.5+-0.2")),
  // 3: add: three equal ones
  error-method(zcalc.add("1.5+-0.1", "2.5+-0.1", "3.5+-0.1")),
  // 4: add: exact terms do not contribute
  error-method(zcalc.add("1.5+-0.1", "2.5")),
  // 5: add: nothing uncertain is 0
  error-method(zcalc.add("1.5", "2.5")),
  // 6: neg passes the error of the operand through
  error-method(zcalc.neg("5.0+-0.1")),
  // 7: abs passes the error of the operand through
  error-method(zcalc.abs("-5.0+-0.1")),
  // 8: mul: relative errors
  error-method(zcalc.mul("2.0+-0.1", "3.0+-0.1")),
  // 9: mul: one uncertain factor
  error-method(zcalc.mul("2.0+-0.1", "3.0")),
  // 10: mul: identical relative errors are counted
  error-method(zcalc.mul("2.0+-0.1", "2.0+-0.1")),
  // 11: div: relative errors
  error-method(zcalc.div("6.0+-0.1", "3.0+-0.1")),
  // 12: pow: base
  error-method(zcalc.pow("3.0+-0.1", "2")),
  // 13: pow: exponent
  error-method(zcalc.pow("2.0", "3.0+-0.1")),
  // 14: pow: nothing uncertain
  error-method(zcalc.pow("3.0", "2")),
  // 15: log: value
  error-method(zcalc.log("100+-1", "10")),
  // 16: sin
  error-method(zcalc.sin("1.00+-0.01")),
  // 17: cos
  error-method(zcalc.cos("1.00+-0.01")),
  // 18: tan
  error-method(zcalc.tan("1.00+-0.01")),
  // 19: arcsin
  error-method(zcalc.asin("0.50+-0.01")),
  // 20: arccos
  error-method(zcalc.acos("0.50+-0.01")),
  // 21: arctan
  error-method(zcalc.atan("1.00+-0.01")),
  // 22: sin without uncertainty
  error-method(zcalc.sin("1.00")),
  // 23: constants have no error
  error-method(zcalc.mul("2.0+-0.1", zcalc.pi)),
  // 24: nested: error of an error
  error-method(zcalc.add(zcalc.mul("2.0+-0.1", "3.0+-0.1"), "1.0+-0.2")),
  // 25: depth 0 shows only the error
  error-method(zcalc.mul("2.0+-0.1", "3.0+-0.1"), depth: 0),
  // 26: sub
  error-method(zcalc.sub("5.0+-0.1", "2.0+-0.2")),
  // 27: sub, equal errors
  error-method(zcalc.sub("5.0+-0.1", "2.0+-0.1")),
  // 28: root: radicand term uses y / (n x)
  error-method(zcalc.sqrt("9.0+-0.3")),
)
