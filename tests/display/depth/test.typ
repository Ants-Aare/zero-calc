#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.0": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter


// #display.variable(value, show-error: false)\
// #display.variable(value, show-error: true)\
//
#let a = zcalc.sqrt("3+-0.5")
#let equation = equation.define($sqrt((b + a^2) times b)$)
#let equation-result = equation(a: a, b: "5.0")
// #display.method-result(equation-result, show-error: false)\
#let value = zcalc.mul(zcalc.add("2+-0.3", "4+-0.4", equation-result), "5+-1")



// #let value = zcalc.add("2+-0.3", "4+-0.4")
// #display.method-result(value, show-error: false)\
// #display.method(value, show-error: true)\
// #display.method-result(value, show-error: true)\

// #display.error(value)\
#display.method(value, show-error: false, depth: 3)\
#display.error-method(value, depth: 2)\
// #display.error-method-result(value, block: true)\


// #let frac1 = box(height: 5em, width: 2em, fill: red.transparentize(50%))
// #let frac3 = context {
//   let measure = measure(frac1)
//   let frac2 = math.frac(frac1, $b$)
//   return move(frac2, dy: measure.height / 3)
//   return frac2
// }

// $
//   lr((frac3))
//   (frac3)
//   lr((#box(frac3)))
//   (#box(frac3))
// $
