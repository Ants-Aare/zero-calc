#import "@preview/zero:0.7.0": *
#import "/src/zero-calc.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter
#let s = zi.second
#set-unit(fraction: "fraction")

#equation.define($a + b$)(a: 5, b: 3)\
#equation.define($a - b$)(a: 5, b: 3)\
#equation.define($-a$)(a: 5, b: 3)\
#equation.define($+a$)(a: 5, b: 3)\
#equation.define($a times b$)(a: 5, b: 3)\
#equation.define($a dot b$)(a: 5, b: 3)\
#equation.define($a b$)(a: 5, b: 3)\
#equation.define($a b c$)(a: 5, b: 3, c: 2)\
#equation.define($a (b + c)$)(a: "5", b: "3", c: "2")\
#equation.define($a / b$)(a: 6, b: 3)\
#equation.define($abs(a)$)(a: -6)\
#equation.define($|a|$)(a: 6)\
#equation.define($a^b$)(a: "6.0", b: "2.0")\
#equation.define($a^2$)(a: "6.0")\
#equation.define($root(b, a)$)(a: "27", b: 3)\
#equation.define($root(3, a)$)(a: "27")\
#equation.define($sqrt(a)$)(a: "36")\
#equation.define($f(x)$)(f-x: 5)\
#equation.define($ln x$)(x: 3)\
#equation.define($ln(x)$)(x: 3)\
#equation.define($ln(e)$)()\
#equation.define($ln e$)()\
#equation.define($log x$)(x: 100)\
#equation.define($log_5 x$)(x: 25)\
#equation.define($log(x)$)(x: 100)\
#equation.define($log_5(x)$)(x: 25)\
#equation.define($log_b (x)$)(x: 25, b: 5)\
#equation.define($sin(x)$)(x: 1.6)\
#equation.define($sin(pi/2)$)()\
#equation.define($cos(x)$)(x: 6)\
#equation.define($cos(2pi)$)()\
#equation.define($tan(x)$)(x: 1)\
#equation.define($(delta d)/(delta t)$)(delta-t: s(5), delta-d: m(20))\
#equation.define($Delta H$)(Delta-H: 5)\
