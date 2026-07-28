#import "/src/lib/zero/src/zero.typ": *
#import "/src/lib.typ": *
#set page(width: auto, height: auto, margin: .5em)
#set-unit(fraction: "fraction")

#let m = zi.meter
#let s = zi.second
#let m-s = zi.m-s
#let kg = zi.kilogram
#let m-s2 = zi.m-s2

#let acceleration-formula = $a times t$
#let kinetic-energy-formula = $1/2 m_1 v^2$

#acceleration-formula\
#kinetic-energy-formula

#let acceleration = function.from-math(acceleration-formula)
#let kinetic-energy = function.from-math(kinetic-energy-formula)
#acceleration(t: s("5"), a: m-s2("2"))
#m-s(10)

#kinetic-energy(m1: zi.kg("75.000"), v: m-s("1.0e1"))\
#kinetic-energy(m1: zi.kg("75.0"), t: s("5.0"), a: m-s2("2.0"), v: acceleration)
