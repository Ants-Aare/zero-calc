/// [skip]
// BUG: the `alt` text of a preferred unit is dropped, so units that zero can not describe by itself panic.
//
// set-preferred-units stores `alt` for the preferred unit (here "Enzyme units"), display-info copies only `.unit`
// to the value, zero then fails to generate an alt description for the unit `U`.
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
  // 1: factor rule: mol/min to enzyme units
  zcalc.convert-units-to-si(zi.declare("mol/min")("1.0")),
)
