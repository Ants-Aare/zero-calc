/// [skip]
#import "/src/lib/symbolica-typst-plugin/symbolica/lib.typ": *
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *

#set page(width: auto, height: auto, margin: .5em)

#let result = parse($x^2$)
#let x = $Delta E = E_"kin" - E_"pot"$
#x

#let result = parse(x)
#to-typst(result)

#inspect(result)

#let zsquare = equation.define(result)
#let zsquare2 = equation.define($x^2$)

#zsquare2(x: zi.meter("5.0"))
#zsquare(x: zi.meter("5.0"))
