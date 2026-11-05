#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#set page(width: auto, height: auto, margin: .5em)

#zcalc.convert-units-to-si(zi.gram("5.0"))\
#zcalc.convert-units-to-si(zi.declare("g/mol")("152.14"))\
#zcalc.convert-units-to-si(zi.declare("mol/mg")("2.0"))\
#zcalc.convert-units(zi.declare("m^3")("5.00e-5"), zi.liter)\
#zcalc.convert-units(zi.declare("mol/m^3")("30.0"), zi.declare("mmol/L"))\
#zcalc.convert-units(zi.liter("2.50"), zi.declare("mL"))\
#zcalc.mul("9.996e-3", "1.00")\
#repr(zcalc.mul(none, "2"))\
#zcalc.add(zi.declare("L/mol")("1.0"), zi.declare("mol^-1 L")("2.0"))\
#zcalc.ln("10.0")\
#zcalc.mul(zcalc.const("0.1"), zcalc.const("3"))
