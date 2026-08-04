#import "/src/lib/zero/src/zero.typ": *
#set page(width: auto, height: auto, margin: .5em)


#num(calc.sin(30deg), round: (precision: 2))\
#num(calc.sin(0.523599rad), round: (precision: 2))\
#num(calc.sin(1800deg / 60), round: (precision: 2))\
#num(calc.sin(108000deg / 60 / 60), round: (precision: 1))

#num(calc.cos(60deg), round: (precision: 2))\
#num(calc.cos(1rad), round: (precision: 1))\
#num(calc.cos(3600deg / 60), round: (precision: 2))\
#num(calc.cos(210000deg / 60 / 60), round: (precision: 2))

#zi.degree(60)\
#zi.degree(30)\
#zi.degree(30)\
