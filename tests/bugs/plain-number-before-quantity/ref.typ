/// [skip]
// INCONSISTENCY: add/sub accept `quantity, number` but panic for `number, quantity`.
//
// normalise-quantities hands the unit of a quantity only to the *following* plain numbers,
// so zcalc.add(zi.m(1), 2) works while zcalc.add(2, zi.m(1)) fails with "All parameters must have the same unit".
// Either both orders should work or both should fail.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add(2.0, m)
  zi.m("3.0"),
  // 2: sub(2.0, m)
  zi.m("1.0"),
)
