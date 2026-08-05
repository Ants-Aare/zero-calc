#import "/src/lib/zero/src/zero.typ": *
#import "/src/zero-calc.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let m = zi.meter.with(exponent: "eng")

#num("1.001e3")\
#num("1.1e2")\
#num("110.0e1")\
#num("110.1e1")\
#num("11.00e2")\
#num("11.01e2")\
#num("1.1")\
#num("1.01")\
#num("1.1e-2")\
#num("2.2e3")\


#pagebreak()
#num("3")
#num("5+-1")
#num("2+-0.5")\
#num("10+-2.2")
#m("2")\
#m("12.022+-0.0001e3")\

#pagebreak()
#num("12e2")
#num("12.33+-0.111")\
#num("12.33+-0.111e2")\
#num("6.2811+-0.00111e2")\
#num("6.7+-0.1e3")\
#num("12.33+-0.16e2")\
#num("6.833333e3")\
#num("68.33333e2")\

#pagebreak()
#num[#(calc.pi + calc.e)+-0.1745]\
#num[#(calc.pi + calc.e + 1)+-0.2]
#pagebreak()

#zcalc.mul("7", "5")\
#zcalc.mul("7", "5+-0.1")\
#zcalc.mul("7.0", "5.0")\
#zcalc.mul("7", "5.0")\
#zcalc.mul("7+-0.5", "5")\
#zcalc.mul("7+-1", "5+-0.45")\
#zcalc.mul("3.4e3", "5.0e1")\

#pagebreak()

#zcalc.add("12", "5")\
#zcalc.add("12", "5+-0.1")\
#zcalc.add("12", "5.0")\
#zcalc.add("12", "5.0")\
#zcalc.add("12+-2", "5")\
#zcalc.add("12+-5", "5+-0.99")\
#zcalc.add("1.2e6", "5.0e1")\
