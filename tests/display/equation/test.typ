#import "/src/lib/zero/src/zero.typ": *
#import "/src/lib.typ": *
#import "@preview/parsely:0.1.1"
#set page(width: auto, height: auto, margin: .5em)

#let eq = $x = log(a^4)$
#let eq = $x = b times -a dot c$
#let eq = $x = (c/a)/b$
#let eq = $x = e^a$
#let eq = $x = sqrt(a)$
#let eq = $x = sin(a)$
#let eq = $x = 101^(a)$
#eq
#let tree = equation.to-tree(eq)

#display.equation(tree)
