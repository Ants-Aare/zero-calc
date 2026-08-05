#import "/src/lib/zero/src/zero.typ": *
#import "/src/zero-calc.typ": *
#import "@preview/parsely:0.1.1"
#set page(width: auto, height: auto, margin: .5em)
#set align(center)

#set-unit(fraction: "fraction")
#let m = zi.meter
#let g = zi.gram
#let s = zi.second
#let g-m2-s-2 = zi.declare("g m^2 s^-2")


#zcalc.div(m[30+-0.3], s[5+-0.4])
#pagebreak()

#let value = zcalc.div(m[30+-1.45], s[5.0+-0.20]) // 30 / 5 = 6
#let value = zcalc.pow(value, 2)                  // 6^2 = 36
#display.method-result(value, block: true)
#display.error-method-result(value, block: true)

#pagebreak()

#let kinetic-energy-math = $
  E_"kin" = 1/2 m v^2
$
#kinetic-energy-math
#let kinetic-energy-function = equation.define(kinetic-energy-math)
#display.method-result(kinetic-energy-function(m: g[10], v: zcalc.div(m[30], s[5.0])))

#pagebreak()

#let kinetic-energy-tree = equation.to-tree(kinetic-energy-math)
#let velocity-tree = equation.isolate-variable(kinetic-energy-tree, $v$)
#math.equation(display.equation(velocity-tree.first()), block: true)

#equation.calculate-tree(velocity-tree, m: g[10], Ekin: g-m2-s-2[180])

