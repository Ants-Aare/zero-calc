/// [skip]
// BUG: the `alt` text of a preferred unit is dropped, so units that zero can not describe by itself panic.
//
// set-preferred-units stores `alt` for the preferred unit (here "Enzyme units"), display-info copies only `.unit`
// to the value, zero then fails to generate an alt description for the unit `U`.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)
#set-unit(fraction: "fraction")

#cases(
  // 1: factor rule: mol/min to enzyme units
  zi.declare("U", alt: "Enzyme units")("1.0e6"),
)
