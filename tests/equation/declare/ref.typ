// Physics formulas defined once with equation.define and evaluated with units;
// `.with(..)` pre-fills a variable (here a constant).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: kinetic energy
  zi.declare("kg m^2 s^-2")("84.4"),
  // 2: area of a circle
  zi.declare("m^2")("80"),
  // 3: area of a circle with more digits
  zi.declare("m^2")("78.5"),
  // 4: Arrhenius (constants via .with)
  num("3.2e3"),
  // 5: vapour pressure (box in the formula, unicode name)
  num("2.8e-1"),
  // 6: with() can be overridden at the call site
  num("3.0"),
)
