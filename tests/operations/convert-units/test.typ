// zcalc.convert-units(value, unit): convert a quantity into any compatible unit.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: m to km
  check(zcalc.convert-units(zi.m("1500.0"), zi.km), float: 1.5),
  // 2: km to m
  check(zcalc.convert-units(zi.km("1.5"), zi.m), float: 1500),
  // 3: h to min
  check(zcalc.convert-units(zi.hour("1.5"), zi.minute), float: 90),
  // 4: h to s
  check(zcalc.convert-units(zi.hour("1.5"), zi.second), float: 5400),
  // 5: s to ms
  check(zcalc.convert-units(zi.second("2.5"), zi.declare("ms")), float: 2500),
  // 6: ms to s
  check(zcalc.convert-units(zi.declare("ms")("2500.0"), zi.second), float: 2.5),
  // 7: with uncertainty
  check(zcalc.convert-units(zi.m("1500.0+-10"), zi.km), float: 1.5, uncertainty: 0.01),
  // 8: g to mg
  check(zcalc.convert-units(zi.gram("1.5"), zi.declare("mg")), float: 1500),
  // 9: kg to g
  check(zcalc.convert-units(zi.kg("1.5"), zi.gram), float: 1500),
  // 10: J to kJ
  check(zcalc.convert-units(zi.J("1500.0"), zi.declare("kJ")), float: 1.5),
  // 11: kWh to J
  check(zcalc.convert-units(zi.declare("kW h")("1.0"), zi.J), float: 3600000),
  // 12: eV to J
  check(zcalc.convert-units(zi.declare("eV")("1.0"), zi.J), float: 1.602176634e-19),
  // 13: J to eV
  check(zcalc.convert-units(zi.J("1.0e-19"), zi.declare("eV")), float: 0.6241509074460763),
  // 14: km/h to m/s
  check(zcalc.convert-units(zi.declare("km/h")("36.0"), zi.declare("m/s")), float: 10),
  // 15: m/s to km/h
  check(zcalc.convert-units(zi.declare("m/s")("10.0"), zi.declare("km/h")), float: 36),
  // 16: L to m^3
  check(zcalc.convert-units(zi.liter("2.5"), zi.declare("m^3")), float: 0.0025),
  // 17: m^3 to L
  check(zcalc.convert-units(zi.declare("m^3")("0.0025"), zi.liter), float: 2.5),
  // 18: m^3 to L, original
  zcalc.convert-units(zi.declare("m^3")("5.00e-5"), zi.liter),
  // 19: mol/m^3 to mmol/L, original
  zcalc.convert-units(zi.declare("mol/m^3")("30.0"), zi.declare("mmol/L")),
  // 20: L to mL, original
  zcalc.convert-units(zi.liter("2.50"), zi.declare("mL")),
  // 21: cm^2 to m^2
  check(zcalc.convert-units(zi.declare("cm^2")("2.5"), zi.declare("m^2")), float: 0.00025),
  // 22: m^2 to cm^2
  check(zcalc.convert-units(zi.declare("m^2")("2.5"), zi.declare("cm^2")), float: 25000),
  // 23: mol/L to mmol/L
  check(zcalc.convert-units(zi.declare("mol/L")("0.150"), zi.declare("mmol/L")), float: 150),
  // 24: ha to m^2
  check(zcalc.convert-units(zi.declare("ha")("2.0"), zi.declare("m^2")), float: 20000),
  // 25: au to km
  check(zcalc.convert-units(zi.declare("au")("1.0"), zi.km), float: 149597870.7),
  // 26: same unit
  check(zcalc.convert-units(zi.m("5.0"), zi.m), float: 5),
  // 27: result of mul
  check(zcalc.convert-units(zcalc.mul(zi.m("2.0"), zi.m("3.0")), zi.declare("cm^2")), float: 60000),
  // 28: result of div
  check(zcalc.convert-units(zcalc.div(zi.m("2.0"), zi.second("3.0")), zi.declare("km/h")), float: 2.4),
  // 29: call-site exponent
  zcalc.convert-units(zi.m("1500.0"), zi.km, exponent: "sci"),
  // 30: none passes through
  repr(zcalc.convert-units(none, zi.m)),
  // 31: celsius to kelvin
  check(zcalc.convert-units(zi.degreeCelsius("25.0"), zi.K), float: 298.15),
)
