// Nested sums and nested products are one operation in the history: (a + b) + c is add(a, b, c).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)
#let source(x) = impl.utility.retrieve-metadata(x).source
#let terms(x) = source(x).data.value.len()
#let method = display.method.with(show-result: false, product: sym.dot)

#cases(
  // 1: (a + b) + c has three terms
  [#source(zcalc.add(zcalc.add("1.0", "2.0"), "3.0")).head #terms(zcalc.add(zcalc.add("1.0", "2.0"), "3.0"))],
  // 2: a + (b + c) as well
  [#terms(zcalc.add("1.0", zcalc.add("2.0", "3.0")))],
  // 3: and both sides at once
  [#terms(zcalc.add(zcalc.add("1.0", "2.0"), zcalc.add("3.0", "4.0")))],
  // 4: a long chain is one sum
  [#terms(range(20).fold("1.0", (x, _) => zcalc.add(x, "1.0")))],
  // 5: products
  [#terms(zcalc.mul(zcalc.mul("2.0", "3.0"), "4.0"))],
  // 6: a long chain of products
  [#terms(range(20).fold("1.5", (x, _) => zcalc.mul(x, "1.1")))],
  // 7: different operations are not merged
  [#source(zcalc.add(zcalc.mul("2.0", "3.0"), "4.0")).head #terms(zcalc.add(zcalc.mul("2.0", "3.0"), "4.0"))],
  // 8: a difference is its own operation
  [#source(zcalc.add(zcalc.sub("5.0", "2.0"), "1.0")).head #terms(zcalc.add(zcalc.sub("5.0", "2.0"), "1.0"))],
  // 9: the sum that was used is unchanged
  [#{ let s = zcalc.add("1.0", "2.0"); let _ = zcalc.add(s, "3.0"); terms(s) }],
  // 10: the value is the same
  [#zcalc.to-float(zcalc.add(zcalc.add("1.0", "2.0"), "3.0"))],
  // 11: the uncertainty is the same
  [#calc.round(zcalc.to-uncertainty(zcalc.add(zcalc.add("1.0+-0.1", "2.0+-0.1"), "3.0+-0.1")), digits: 6)],
  // 12: shown without parentheses, like before
  method(zcalc.add(zcalc.add("1.0", "2.0"), "3.0")),
  // 13: products as well
  method(zcalc.mul(zcalc.mul("2.0", "3.0"), "4.0")),
  // 14: depth counts operations: the merged sum is one level
  method(zcalc.add(zcalc.add("1.0", "2.0"), "3.0"), depth: 1),
  // 15: a different operation in between keeps the levels
  method(zcalc.mul(zcalc.add("1.0", "2.0"), "3.0"), depth: 1),
  // 16: in equations the variables are boundaries and stay whole
  [#terms(equation.define($a + b$)(a: zcalc.add("1.0", "2.0"), b: "3.0"))],
  // 17: a variable of an equation is shown as its value
  method(equation.define($a + b$)(a: zcalc.add("1.0", "2.0"), b: "3.0"), depth: 1),
  // 18: the uncertainty calculation of a merged sum
  display.error-method(zcalc.add(zcalc.add("1.0+-0.1", "2.0+-0.2"), "3.0+-0.3"), show-result: false),
)
