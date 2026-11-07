/// [skip]
// BUG: asin/acos/atan with unit: sym.prime.double (arcseconds) are 10x too small.
//
// The divider for arcseconds is `1deg / 360`, it has to be `1deg / 3600`.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: asin(0.5) in arcseconds
  zi.arcsecond("1e5"),
  // 2: acos(0.5) in arcseconds
  zi.arcsecond("2e5"),
  // 3: atan(1.0) in arcseconds
  zi.arcsecond("1.6e5"),
)
