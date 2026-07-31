#import "/src/lib/zero/src/zero.typ": *
#import "/src/lib.typ": *
#import "@preview/parsely:0.1.1"
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter
#let s = zi.second
#set-unit(fraction: "fraction")

// #let tree = equation.to-tree($x = a b + c$)
// #let tree = equation.to-tree($x = a / b$)
#let eq = $x = log(a^4)$
#let eq = $x = b times -a dot c$
#let eq = $x = (c/a)/b$
#let eq = $x = e^a$
#let eq = $x = sqrt(a)$
#let eq = $x = sin(a)$
#let eq = $x = 101^(a)$
#eq
#let tree = equation.to-tree(eq)

#let isolated-tree = equation.isolate-variable(tree, $a$)
// #equation.calculate-tree(tree, a: "5.00")\
#equation.calculate-tree(isolated-tree, x: "0.5")\
#parsely.render.waterfall(tree)\
#parsely.render.waterfall(isolated-tree.at(0))\
// #parsely.render.waterfall(isolated-tree.at(1))\
