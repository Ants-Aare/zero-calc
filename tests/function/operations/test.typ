#import "/src/lib/zero/src/zero.typ": *
#import "/src/lib.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter
#let s = zi.second
#set-unit(fraction: "fraction")

#function.calculate-math($a + b$)(a: 5, b: 3)\
#function.calculate-math($a - b$)(a: 5, b: 3)\
#function.calculate-math($-a$)(a: 5, b: 3)\
#function.calculate-math($+a$)(a: 5, b: 3)\
#function.calculate-math($a times b$)(a: 5, b: 3)\
#function.calculate-math($a dot b$)(a: 5, b: 3)\
#function.calculate-math($a b$)(a: 5, b: 3)\
#function.calculate-math($a b c$)(a: 5, b: 3, c: 2)\
#function.calculate-math($a (b + c)$)(a: 5, b: 3, c: 2)\
#function.calculate-math($a / b$)(a: 6, b: 3)\
#function.calculate-math($abs(a)$)(a: -6)\
#function.calculate-math($|a|$)(a: 6)\
#function.calculate-math($a^b$)(a: "6.0", b: "2.0")\
#function.calculate-math($a^2$)(a: "6.0")\
#function.calculate-math($root(b, a)$)(a: "27", b: 3)\
#function.calculate-math($root(3, a)$)(a: "27")\
#function.calculate-math($sqrt(a)$)(a: "36")\
#function.calculate-math($f(x)$)(f-x: 5)\
#function.calculate-math($ln x$)(x: 3)\
#function.calculate-math($ln(x)$)(x: 3)\
#function.calculate-math($ln(e)$)()\
#function.calculate-math($ln e$)()\
#function.calculate-math($log x$)(x: 100)\
#function.calculate-math($log_5 x$)(x: 25)\
#function.calculate-math($log(x)$)(x: 100)\
#function.calculate-math($log_5(x)$)(x: 25)\
#function.calculate-math($log_b (x)$)(x: 25, b: 5)\
#function.calculate-math($sin(x)$)(x: 1.6)\
#function.calculate-math($sin(pi/2)$)()\
#function.calculate-math($cos(x)$)(x: 6)\
#function.calculate-math($cos(2pi)$)()\
#function.calculate-math($tan(x)$)(x: 1)\
#function.calculate-math($(delta d)/(delta t)$)(delta-t: s(5), delta-d: m(20))\
#function.calculate-math($Delta H$)(Delta-H: 5)\
