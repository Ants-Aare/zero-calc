#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.0": *
#set page(width: auto, height: auto, margin: .5em)

// #set-num(round: (precision: 2, mode: "figures"))
#set-unit(fraction: "fraction")

#zcalc.set-preferred-units(
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
  ),
)

#zcalc.convert-units-to-si(zi.ohm(1))\
#zcalc.convert-units-to-si(zi.volt(1))\
#zcalc.convert-units-to-si(zi.newton(1))\
#zcalc.convert-units-to-si(zi.pascal(1))\
#zcalc.convert-units-to-si(zi.henry(1))\
#zcalc.convert-units-to-si(zi.farad(1))\
#zcalc.convert-units-to-si(zi.watt(1))\
#zcalc.convert-units-to-si(zi.joule(1))\
#zcalc.convert-units-to-si(zi.hertz(1))\
#zcalc.mul(zi.watt(5), zi.minute(30), convert-si: true, exponent: "eng")\


