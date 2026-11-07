/// [skip]
// BUG: asin/acos/atan with unit: sym.prime.double (arcseconds) are 10x too small.
//
// The divider for arcseconds is `1deg / 360`, it has to be `1deg / 3600`.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: asin(0.5) in arcseconds
  check(zcalc.asin("0.5", unit: sym.prime.double), float: 108000),
  // 2: acos(0.5) in arcseconds
  check(zcalc.acos("0.5", unit: sym.prime.double), float: 216000),
  // 3: atan(1.0) in arcseconds
  check(zcalc.atan("1.0", unit: sym.prime.double), float: 162000),
)
