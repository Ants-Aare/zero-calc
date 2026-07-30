#import "/src/lib/zero/src/zero.typ": *
#import "/src/lib.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter
#let s = zi.second
#set-unit(fraction: "fraction")

#equation.calculate($a + b$)(a: 5, b: 3)\
#equation.calculate($a - b$)(a: 5, b: 3)\
#equation.calculate($-a$)(a: 5, b: 3)\
#equation.calculate($+a$)(a: 5, b: 3)\
#equation.calculate($a times b$)(a: 5, b: 3)\
#equation.calculate($a dot b$)(a: 5, b: 3)\
#equation.calculate($a b$)(a: 5, b: 3)\
#equation.calculate($a b c$)(a: 5, b: 3, c: 2)\
#equation.calculate($a (b + c)$)(a: 5, b: 3, c: 2)\
#equation.calculate($a / b$)(a: 6, b: 3)\
#equation.calculate($abs(a)$)(a: -6)\
#equation.calculate($|a|$)(a: 6)\
#equation.calculate($a^b$)(a: "6.0", b: "2.0")\
#equation.calculate($a^2$)(a: "6.0")\
#equation.calculate($root(b, a)$)(a: "27", b: 3)\
#equation.calculate($root(3, a)$)(a: "27")\
#equation.calculate($sqrt(a)$)(a: "36")\
#equation.calculate($f(x)$)(f-x: 5)\
#equation.calculate($ln x$)(x: 3)\
#equation.calculate($ln(x)$)(x: 3)\
#equation.calculate($ln(e)$)()\
#equation.calculate($ln e$)()\
#equation.calculate($log x$)(x: 100)\
#equation.calculate($log_5 x$)(x: 25)\
#equation.calculate($log(x)$)(x: 100)\
#equation.calculate($log_5(x)$)(x: 25)\
#equation.calculate($log_b (x)$)(x: 25, b: 5)\
#equation.calculate($sin(x)$)(x: 1.6)\
#equation.calculate($sin(pi/2)$)()\
#equation.calculate($cos(x)$)(x: 6)\
#equation.calculate($cos(2pi)$)()\
#equation.calculate($tan(x)$)(x: 1)\
#equation.calculate($(delta d)/(delta t)$)(delta-t: s(5), delta-d: m(20))\
#equation.calculate($Delta H$)(Delta-H: 5)\
