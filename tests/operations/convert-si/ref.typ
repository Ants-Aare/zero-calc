// zcalc.convert-units-to-si and the convert-si argument of the operations.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: km
  zi.m("1.5e3"),
  // 2: m is already SI
  zi.m("1.5"),
  // 3: cm
  zi.m("1.5e-2"),
  // 4: dm
  zi.m("5.0e-1"),
  // 5: mm with uncertainty
  zi.m("1.5+-0.1e-3"),
  // 6: micro (µ)
  zi.m("1.5e-6"),
  // 7: nano
  zi.m("5.00e-7"),
  // 8: kg is already SI
  zi.kg("5.0"),
  // 9: g
  zi.kg("5.0e-3"),
  // 10: mg
  zi.kg("5.0e-6"),
  // 11: µg
  zi.kg("5.0e-9"),
  // 12: Mg
  zi.kg("5.0e3"),
  // 13: tonne
  zi.kg("5.0e3"),
  // 14: minute
  zi.s("1.2e2"),
  // 15: hour
  zi.s("7.2e3"),
  // 16: day
  zi.s("1.7e5"),
  // 17: ms
  zi.s("2.0e-3"),
  // 18: Hz
  zi.declare("s^-1")("2.0"),
  // 19: kHz
  zi.declare("s^-1")("2.0e3"),
  // 20: N
  zi.declare("kg m s^-2")("5.0"),
  // 21: kN
  zi.declare("kg m s^-2")("5.0e3"),
  // 22: mN
  zi.declare("kg m s^-2")("5.0e-3"),
  // 23: kJ
  zi.declare("kg m^2 s^-2")("2.0e3"),
  // 24: kPa
  zi.declare("kg m^-1 s^-2")("2.0e3"),
  // 25: mV
  zi.declare("kg m^2 s^-3 A^-1")("2.0e-3"),
  // 26: milliohm
  zi.declare("kg m^2 s^-3 A^-2")("5.0e-3"),
  // 27: mA
  zi.A("5.0e-3"),
  // 28: mK
  zi.K("5.0e-3"),
  // 29: mmol
  zi.mol("5.0e-3"),
  // 30: mcd (not centi-day)
  zi.cd("5.0e-3"),
  // 31: cd is already SI (not centi-day)
  zi.cd("5.0"),
  // 32: mGy (milligray, not mega-year)
  zi.declare("m^2 s^-2")("5.0e-3"),
  // 33: litre
  zi.declare("m^3")("2.0e-3"),
  // 34: millilitre
  zi.declare("m^3")("2.0e-6"),
  // 35: hectare
  zi.declare("m^2")("2.0e4"),
  // 36: electronvolt
  zi.declare("kg m^2 s^-2")("3.2e-19"),
  // 37: keV
  zi.declare("kg m^2 s^-2")("3.2e-16"),
  // 38: astronomical unit
  zi.m("3.0e11"),
  // 39: dalton
  zi.kg("3.3e-27"),
  // 40: celsius to kelvin
  zi.K("298.2"),
  // 41: celsius with uncertainty (offset, no scale)
  zi.K("298.2+-0.1"),
  // 42: celsius per second (interval, no offset)
  zi.declare("K/s")("25.0"),
  // 43: K is already SI
  zi.K("25.0"),
  // 44: mol/L
  zi.declare("mol m^-3")("2.0e3"),
  // 45: mmol/L
  zi.declare("mol m^-3")("2.0"),
  // 46: km/h
  zi.declare("m/s")("10.0"),
  // 47: m/s^2 is already SI
  zi.declare("m/s^2")("9.81"),
  // 48: cm^2
  zi.declare("m^2")("2.0e-4"),
  // 49: cm^-3
  zi.declare("m^-3")("2.0e6"),
  // 50: g/cm^3
  zi.declare("kg m^-3")("1.0e3"),
  // 51: min^-1
  zi.declare("s^-1")("2.000"),
  // 52: m per ms
  zi.declare("m/s")("5.0e3"),
  // 53: kW h
  zi.declare("kg m^2 s^-2")("3.6e6"),
  // 54: g/mol, original
  zi.declare("kg/mol")("1.5214e-1"),
  // 55: mol/mg, original
  zi.declare("mol/kg")("2.0e6"),
  // 56: unitless numbers are unchanged
  num("5.0"),
  // 57: unitless numbers keep their uncertainty
  num("5.0+-0.1"),
  // 58: units without a rule are left alone
  zi.declare("furlong", alt: "furlong")("5.0"),
  // 59: bar is left alone
  zi.declare("bar", alt: "bar")("2.0"),
  // 60: convert twice is a no-op
  zi.m("1.5e3"),
  // 61: cm^-2
  zi.declare("m^-2")("1.5e5"),
  // 62: cd, kg: unchanged int
  zi.kg("15"),
  // 63: mg, int
  zi.kg("1.5e-5"),
  // 64: cm^3
  zi.declare("m^3")("1.5e-5"),
  // 65: mm with uncertainty, 4 digits
  zi.m("1.2390+-0.0001"),
  // 66: km/h
  zi.declare("m/s")("1.0"),
  // 67: 1/h
  zi.declare("s^-1")("6e-4"),
  // 68: 1/h^2
  zi.declare("s^-2")("2e-7"),
  // 69: eng exponent is dropped
  zi.declare("kg m^2 s^-2")("5.123e3"),
  // 70: litre, int
  zi.declare("m^3")("1.5e-2"),
  // 71: g/cm^3, 3 digits
  zi.declare("kg m^-3")("1.23e2"),
  // 72: celsius, int
  zi.K("298"),
  // 73: km/h * min with convert-si
  zi.m("3e3"),
)
