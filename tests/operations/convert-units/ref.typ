// zcalc.convert-units(value, unit): convert a quantity into any compatible unit.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: m to km
  zi.km("1.5000"),
  // 2: km to m
  zi.m("1.5e3"),
  // 3: h to min
  zi.minute("90"),
  // 4: h to s
  zi.s("5.4e3"),
  // 5: s to ms
  zi.declare("ms")("2.5e3"),
  // 6: ms to s
  zi.s("2.5000"),
  // 7: with uncertainty
  zi.km("1.500+-0.010"),
  // 8: g to mg
  zi.declare("mg")("1.5e3"),
  // 9: kg to g
  zi.gram("1.5e3"),
  // 10: J to kJ
  zi.declare("kJ")("1.5000"),
  // 11: kWh to J
  zi.J("3.6e6"),
  // 12: eV to J
  zi.J("1.6e-19"),
  // 13: J to eV
  zi.declare("eV")("6.2e-1"),
  // 14: km/h to m/s
  zi.declare("m/s")("10.0"),
  // 15: m/s to km/h
  zi.declare("km/h")("36.0"),
  // 16: L to m^3
  zi.declare("m^3")("2.5e-3"),
  // 17: m^3 to L
  zi.liter("2.5"),
  // 18: m^3 to L, original
  zi.liter("5.00e-2"),
  // 19: mol/m^3 to mmol/L, original
  zi.declare("mmol/L")("30.0"),
  // 20: L to mL, original
  zi.declare("mL")("2.50e3"),
  // 21: cm^2 to m^2
  zi.declare("m^2")("2.5e-4"),
  // 22: m^2 to cm^2
  zi.declare("cm^2")("2.5e4"),
  // 23: mol/L to mmol/L
  zi.declare("mmol/L")("1.50e2"),
  // 24: ha to m^2
  zi.declare("m^2")("2.0e4"),
  // 25: au to km
  zi.km("1.5e8"),
  // 26: same unit
  zi.m("5.0"),
  // 27: result of mul
  zi.declare("cm^2")("6.0e4"),
  // 28: result of div
  zi.declare("km/h")("2.4"),
  // 29: call-site exponent
  zi.km("1.5000", exponent: "sci"),
  // 30: none passes through
  "none",
  // 31: celsius to kelvin
  zi.K("2.982e2"),
)
