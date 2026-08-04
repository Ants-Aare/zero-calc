#import "/src/lib.typ": *
#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)
#let rad = zi.radian
#let rad = zi.rad
#let arcsecond = zi.arcsecond
#let arcminute = zi.arcminute
#let deg = zi.degree

#zcalc.sin(deg("30"))\
#zcalc.sin(rad("0.52"))\
#zcalc.sin(arcminute("1.8e3"))\
#zcalc.sin(arcsecond("1e5"))\

#zcalc.cos(deg("60"))\
#zcalc.cos(rad("1"))\
#zcalc.cos(arcminute("3.6e3"))\
#zcalc.cos(arcsecond("2.1e5"))\

#zcalc.acos("0.5")\
#zcalc.asin("0.5")\
#zcalc.atan("0.5")\
