// zcalc.convert-units-to-si and the convert-si argument of the operations.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: km
  check(zcalc.convert-units-to-si(zi.km("1.5")), float: 1500),
  // 2: m is already SI
  zcalc.convert-units-to-si(zi.m("1.5")),
  // 3: cm
  check(zcalc.convert-units-to-si(zi.cm("1.5")), float: 0.015),
  // 4: dm
  check(zcalc.convert-units-to-si(zi.declare("dm")("5.0")), float: 0.5),
  // 5: mm with uncertainty
  check(zcalc.convert-units-to-si(zi.mm("1.5+-0.1")), float: 0.0015, uncertainty: 0.0001),
  // 6: micro (µ)
  check(zcalc.convert-units-to-si(zi.declare("µm")("1.5")), float: 1.5e-6),
  // 7: nano
  check(zcalc.convert-units-to-si(zi.nm("500")), float: 5e-7),
  // 8: kg is already SI
  zcalc.convert-units-to-si(zi.kg("5.0")),
  // 9: g
  check(zcalc.convert-units-to-si(zi.gram("5.0")), float: 0.005),
  // 10: mg
  check(zcalc.convert-units-to-si(zi.declare("mg")("5.0")), float: 5e-6),
  // 11: µg
  check(zcalc.convert-units-to-si(zi.declare("µg")("5.0")), float: 5e-9),
  // 12: Mg
  check(zcalc.convert-units-to-si(zi.declare("Mg")("5.0")), float: 5000),
  // 13: tonne
  check(zcalc.convert-units-to-si(zi.declare("t")("5.0")), float: 5000),
  // 14: minute
  check(zcalc.convert-units-to-si(zi.minute("2.0")), float: 120),
  // 15: hour
  check(zcalc.convert-units-to-si(zi.hour("2.0")), float: 7200),
  // 16: day
  check(zcalc.convert-units-to-si(zi.declare("d")("2.0")), float: 172800),
  // 17: ms
  check(zcalc.convert-units-to-si(zi.declare("ms")("2.0")), float: 0.002),
  // 18: Hz
  zcalc.convert-units-to-si(zi.Hz("2.0")),
  // 19: kHz
  check(zcalc.convert-units-to-si(zi.declare("kHz")("2.0")), float: 2000),
  // 20: N
  zcalc.convert-units-to-si(zi.N("5.0")),
  // 21: kN
  check(zcalc.convert-units-to-si(zi.declare("kN")("5.0")), float: 5000),
  // 22: mN
  check(zcalc.convert-units-to-si(zi.declare("mN")("5.0")), float: 0.005),
  // 23: kJ
  check(zcalc.convert-units-to-si(zi.declare("kJ")("2.0")), float: 2000),
  // 24: kPa
  check(zcalc.convert-units-to-si(zi.declare("kPa")("2.0")), float: 2000),
  // 25: mV
  check(zcalc.convert-units-to-si(zi.declare("mV")("2.0")), float: 0.002),
  // 26: milliohm
  check(zcalc.convert-units-to-si(zi.declare("mΩ")("5.0")), float: 0.005),
  // 27: mA
  check(zcalc.convert-units-to-si(zi.declare("mA")("5.0")), float: 0.005),
  // 28: mK
  check(zcalc.convert-units-to-si(zi.declare("mK")("5.0")), float: 0.005),
  // 29: mmol
  check(zcalc.convert-units-to-si(zi.declare("mmol")("5.0")), float: 0.005),
  // 30: mcd (not centi-day)
  check(zcalc.convert-units-to-si(zi.declare("mcd")("5.0")), float: 0.005),
  // 31: cd is already SI (not centi-day)
  zcalc.convert-units-to-si(zi.cd("5.0")),
  // 32: mGy (milligray, not mega-year)
  check(zcalc.convert-units-to-si(zi.declare("mGy")("5.0")), float: 0.005),
  // 33: litre
  check(zcalc.convert-units-to-si(zi.declare("L")("2.0")), float: 0.002),
  // 34: millilitre
  check(zcalc.convert-units-to-si(zi.declare("mL")("2.0")), float: 2e-6),
  // 35: hectare
  check(zcalc.convert-units-to-si(zi.declare("ha")("2.0")), float: 20000),
  // 36: electronvolt
  check(zcalc.convert-units-to-si(zi.declare("eV")("2.0")), float: 3.204353268e-19),
  // 37: keV
  check(zcalc.convert-units-to-si(zi.declare("keV")("2.0")), float: 3.204353268e-16),
  // 38: astronomical unit
  check(zcalc.convert-units-to-si(zi.declare("au")("2.0")), float: 299195741400),
  // 39: dalton
  check(zcalc.convert-units-to-si(zi.declare("Da")("2.0")), float: 3.32107813784e-27),
  // 40: celsius to kelvin
  check(zcalc.convert-units-to-si(zi.degreeCelsius("25.0")), float: 298.15),
  // 41: celsius with uncertainty (offset, no scale)
  check(zcalc.convert-units-to-si(zi.degreeCelsius("25.0+-0.1")), float: 298.15, uncertainty: 0.1),
  // 42: celsius per second (interval, no offset)
  check(zcalc.convert-units-to-si(zi.declare("°C/s")("25.0")), float: 25),
  // 43: K is already SI
  zcalc.convert-units-to-si(zi.K("25.0")),
  // 44: mol/L
  check(zcalc.convert-units-to-si(zi.declare("mol/L")("2.0")), float: 2000),
  // 45: mmol/L
  check(zcalc.convert-units-to-si(zi.declare("mmol/L")("2.0")), float: 2),
  // 46: km/h
  check(zcalc.convert-units-to-si(zi.declare("km/h")("36.0")), float: 10),
  // 47: m/s^2 is already SI
  zcalc.convert-units-to-si(zi.declare("m/s^2")("9.81")),
  // 48: cm^2
  check(zcalc.convert-units-to-si(zi.declare("cm^2")("2.0")), float: 0.0002),
  // 49: cm^-3
  check(zcalc.convert-units-to-si(zi.declare("cm^-3")("2.0")), float: 2000000),
  // 50: g/cm^3
  check(zcalc.convert-units-to-si(zi.declare("g/cm^3")("1.0")), float: 1000),
  // 51: min^-1
  check(zcalc.convert-units-to-si(zi.declare("min^-1")("120.0")), float: 2),
  // 52: m per ms
  check(zcalc.convert-units-to-si(zi.declare("m ms^-1")("5.0")), float: 5000),
  // 53: kW h
  check(zcalc.convert-units-to-si(zi.declare("kW h")("1.0")), float: 3600000),
  // 54: g/mol, original
  zcalc.convert-units-to-si(zi.declare("g/mol")("152.14")),
  // 55: mol/mg, original
  zcalc.convert-units-to-si(zi.declare("mol/mg")("2.0")),
  // 56: unitless numbers are unchanged
  check(zcalc.convert-units-to-si("5.0"), float: 5),
  // 57: unitless numbers keep their uncertainty
  check(zcalc.convert-units-to-si("5.0+-0.1"), float: 5, uncertainty: 0.1),
  // 58: units without a rule are left alone
  zcalc.convert-units-to-si(zi.declare("furlong", alt: "furlong")("5.0")),
  // 59: bar is left alone
  zcalc.convert-units-to-si(zi.declare("bar", alt: "bar")("2.0")),
  // 60: convert twice is a no-op
  check(zcalc.convert-units-to-si(zcalc.convert-units-to-si(zi.km("1.5"))), float: 1500),
  // 61: cm^-2
  check(zcalc.convert-units-to-si(zi.declare("cm^-2")(15)), float: 150000),
  // 62: cd, kg: unchanged int
  zcalc.convert-units-to-si(zi.kg(15)),
  // 63: mg, int
  check(zcalc.convert-units-to-si(zi.declare("mg")(15)), float: 1.5e-5),
  // 64: cm^3
  check(zcalc.convert-units-to-si(zi.declare("cm^3")(15)), float: 1.5e-5),
  // 65: mm with uncertainty, 4 digits
  check(zcalc.convert-units-to-si(zi.declare("mm")("1239+-0.1")), float: 1.239),
  // 66: km/h
  check(zcalc.convert-units-to-si(zi.km-h("3.6")), float: 1),
  // 67: 1/h
  check(zcalc.convert-units-to-si(zi.declare("1/h")(2)), float: 2/3600),
  // 68: 1/h^2
  check(zcalc.convert-units-to-si(zi.declare("1/h^2")(2)), float: 2/3600/3600),
  // 69: eng exponent is dropped
  check(zcalc.convert-units-to-si(zi.J(5123, exponent: "eng")), float: 5123),
  // 70: litre, int
  check(zcalc.convert-units-to-si(zi.liter(15)), float: 0.015),
  // 71: g/cm^3, 3 digits
  check(zcalc.convert-units-to-si(zi.g-cm3("0.123")), float: 123),
  // 72: celsius, int
  check(zcalc.convert-units-to-si(zi.degreeCelsius(25)), float: 298.15),
  // 73: km/h * min with convert-si
  check(zcalc.mul(zi.km-h(5), zi.minute(30), convert-si: true), float: 2500),
)
