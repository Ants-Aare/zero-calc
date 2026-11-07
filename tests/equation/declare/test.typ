// Physics formulas defined once with equation.define and evaluated with units;
// `.with(..)` pre-fills a variable (here a constant).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: kinetic energy
  check(equation.define($(m_1 v^2)/2$)(m-1: zi.kg("75.0"), v: zi.m-s("1.50")), float: 84.375),
  // 2: area of a circle
  check(equation.define($pi r^2$)(r: zi.m("5")), float: 25*calc.pi),
  // 3: area of a circle with more digits
  check(equation.define($pi r^2$)(r: zi.m("5.00")), float: 25*calc.pi),
  // 4: Arrhenius (constants via .with)
  check(equation.define($A dot e^(E_A/(R dot T))$).with(R: zcalc.const(zi.declare("J mol^-1 K^-1")("8.314")))(A: zcalc.const(1), E-A: zi.declare("J mol^-1")("20e3"), T: zi.K("298.15")), float: 3191.8566035855292),
  // 5: vapour pressure (box in the formula, unicode name)
  check(equation.define($x_B(T_0) dot e^(- (#box(inset: 1em)[$Delta H_(B,m)$])/R dot (1 / T - 1 / T_0))$).with(R: zcalc.const(zi.declare("J mol^-1 K^-1")("8.314")))(Delta-H-Bm: zi.declare("J mol^-1")("25.38e3"), x-B-T-0: "0.11", T: zi.K("298.15"), T-0: zi.K("273.15")), float: 0.2807822927773698),
  // 6: with() can be overridden at the call site
  equation.define($a + b$).with(a: "1.0")(b: "2.0"),
)
