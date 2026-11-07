// zcalc.set-preferred-units: SI base unit combinations are displayed with the preferred (named) unit.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)
#set-unit(fraction: "fraction")

#cases(
  // 1: ohm
  zi.ohm(1),
  // 2: volt
  zi.volt(1),
  // 3: newton
  zi.newton(1),
  // 4: pascal
  zi.pascal(1),
  // 5: henry
  zi.henry(1),
  // 6: farad
  zi.farad(1),
  // 7: watt
  zi.watt(1),
  // 8: joule
  zi.joule(1),
  // 9: hertz (exact match)
  zi.hertz(1),
  // 10: m^3 becomes litres (factor 1e3)
  zi.liter(5),
  // 11: inverse litres
  zi.declare("L^-1")(5),
  // 12: kilojoule is converted and shown as joule
  zi.declare("J")("9e3"),
  // 13: product of watt and minutes
  zi.declare("kJ")(9),
  // 14: computed unit: V * A
  zi.watt("6.0"),
  // 15: computed unit: kg m s^-2 * m
  zi.joule("6.0"),
  // 16: computed unit: J / s
  zi.watt("2.0"),
  // 17: computed unit: V / A
  zi.ohm("2.0"),
  // 18: computed unit: 1 / s
  zi.hertz("2.5e-1"),
  // 19: units without a rule stay as they are
  zi.declare("m s")("6.0"),
)
