// Characterisation of how the exponent of a result is chosen.
// add/sub keep the highest exponent of their operands (so mantissas outside [1, 10) can appear),
// mul/div/pow/root/log use the order of magnitude of the result (10..99 stay plain, below 1 uses an exponent).
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add: 1 + 1e3 (from the existing tests)
  zcalc.add("1", "1e3"),
  // 2: add: 1e1 + 1e2
  zcalc.add("1e1", "1e2"),
  // 3: add: 1000 + 1e2
  zcalc.add("1000", "1e2"),
  // 4: add: 1 + 1e-1
  zcalc.add("1", "1e-1"),
  // 5: add: 1 + 1e-2
  zcalc.add("1", "1e-2"),
  // 6: add: 1e-3 + 1e-2
  zcalc.add("1e-3", "1e-2"),
  // 7: add: 6e2 + 6e2
  zcalc.add("6e2", "6e2"),
  // 8: add: 2.5e-1 + 7.5e-1 stays in e-1
  zcalc.add("2.50e-1", "7.50e-1"),
  // 9: sub: 1.0 km - 5.0 m
  zcalc.sub(zi.km("1.0"), zi.m("5.0"), convert-si: true),
  // 10: mul: rounding up to the next power of ten in exponent notation
  zcalc.mul("9.996e-3", "1.00"),
  // 11: mul: rounding up to the next power of ten (3.0e2)
  zcalc.mul("1.00e2", "3.0"),
  // 12: sin of a small angle
  zcalc.sin("0.010"),
)
