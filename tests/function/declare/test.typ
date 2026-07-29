#import "/src/lib/zero/src/zero.typ": *
#import "/src/lib.typ": *
#set page(width: auto, height: auto, margin: .5em)

#let j-mol-k = zi.declare("J mol^-1 K^-1")
#let j-mol = zi.declare("J mol^-1")

#set-unit(fraction: "fraction")

#let kinetic-energy-formula = $(m_1 v^2)/2$
#kinetic-energy-formula
#let kinetic-energy = function.calculate-math(kinetic-energy-formula)
#kinetic-energy(m1: zi.kg("75.0"), v: zi.m-s("1.50"))

#let circle-area-formula = $pi r^2$
#circle-area-formula
#let circle-area = function.calculate-math(circle-area-formula)
#circle-area(r: zi.m("5"))


#let universal-gas-constant = zcalc.const(j-mol-k("8.314"))
#let arrhenius-equation = $A dot e^(E_A/(R dot T))$
#arrhenius-equation
#let arrhenius = function.calculate-math(arrhenius-equation).with(R: universal-gas-constant)
#arrhenius(A: zcalc.const(1), EA: zi.joule("20e3"), T: zi.K("298.15"))

#let sättigungs-molenbruch-gleichung = $x_B(T_0) dot e^(- (#box(inset: 1em)[$Delta H_(B,m)$])/R dot (1 / T - 1 / T_0))$
#sättigungs-molenbruch-gleichung
#let sättigungs-molenbruch = function.calculate-math(sättigungs-molenbruch-gleichung).with(R: universal-gas-constant)

#sättigungs-molenbruch(
  Delta-HB-m: j-mol("25.38e3"),
  xB-T0: "0.11",
  T: zi.K("298.15"),
  T0: zi.K("273.15"),
)
