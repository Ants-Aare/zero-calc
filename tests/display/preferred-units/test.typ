// zcalc.set-preferred-units: SI base unit combinations are displayed with the preferred (named) unit.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)
#set-unit(fraction: "fraction")


#place(zcalc.set-preferred-units(
  (
    (match: zi.declare("A^2 s^4 kg^-1 m^-2"), preferred: zi.farad, exact-match: false),
    (match: zi.declare("kg m^2 s^-3 A^-2"), preferred: zi.ohm, exact-match: false),
    (match: zi.declare("kg m^2 s^-3 A^-1"), preferred: zi.volt, exact-match: false),
    (match: zi.declare("kg m^2 s^-2 A^-2"), preferred: zi.henry, exact-match: false),
    (match: zi.declare("kg m^2 s^-3"), preferred: zi.watt, exact-match: false),
    (match: zi.declare("kg m^2 s^-2"), preferred: zi.joule, exact-match: false),
    (match: zi.declare("kg m s^-2"), preferred: zi.newton, exact-match: false),
    (match: zi.declare("kg m^-1 s^-2"), preferred: zi.pascal, exact-match: false),
    (match: zi.declare("s^-1"), preferred: zi.hertz, exact-match: true),
    (
      match: zi.declare("mol s^-1"),
      preferred: zi.declare("U", alt: "Enzyme units"),
      exact-match: false,
      factor: 60e6,
    ),
    (match: zi.m3, preferred: zi.liter, exact-match: false, factor: 1e3),
  ),
))


#cases(
  // 1: ohm
  zcalc.convert-units-to-si(zi.ohm(1)),
  // 2: volt
  zcalc.convert-units-to-si(zi.volt(1)),
  // 3: newton
  zcalc.convert-units-to-si(zi.newton(1)),
  // 4: pascal
  zcalc.convert-units-to-si(zi.pascal(1)),
  // 5: henry
  zcalc.convert-units-to-si(zi.henry(1)),
  // 6: farad
  zcalc.convert-units-to-si(zi.farad(1)),
  // 7: watt
  zcalc.convert-units-to-si(zi.watt(1)),
  // 8: joule
  zcalc.convert-units-to-si(zi.joule(1)),
  // 9: hertz (exact match)
  zcalc.convert-units-to-si(zi.hertz(1)),
  // 10: m^3 becomes litres (factor 1e3)
  zcalc.convert-units-to-si(zi.liter(5)),
  // 11: inverse litres
  zcalc.convert-units-to-si(zi.declare("L^-1")(5)),
  // 12: kilojoule is converted and shown as joule
  zcalc.convert-units-to-si(zi.declare("kJ")(9)),
  // 13: product of watt and minutes
  zcalc.mul(zi.watt(5), zi.minute(30), convert-si: true, exponent: "eng"),
  // 14: computed unit: V * A
  zcalc.mul(zi.declare("kg m^2 s^-3 A^-1")("2.0"), zi.A("3.0")),
  // 15: computed unit: kg m s^-2 * m
  zcalc.mul(zi.declare("kg m s^-2")("2.0"), zi.m("3.0")),
  // 16: computed unit: J / s
  zcalc.div(zi.declare("kg m^2 s^-2")("6.0"), zi.s("3.0")),
  // 17: computed unit: V / A
  zcalc.div(zi.declare("kg m^2 s^-3 A^-1")("6.0"), zi.A("3.0")),
  // 18: computed unit: 1 / s
  zcalc.div("1.0", zi.s("4.0")),
  // 19: units without a rule stay as they are
  zcalc.mul(zi.m("2.0"), zi.s("3.0")),
  // 20: factor rule: mol/min to enzyme units
  zcalc.convert-units-to-si(zi.declare("mol/min")("1.0")),
  // 21: partial match keeps the remaining units
  zcalc.mul(zi.declare("kg m^2 s^-3 A^-1")("2.0"), zi.m("3.0")),
)
