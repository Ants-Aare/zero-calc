// Characterisation of how the exponent of a result is chosen.
// add/sub keep the highest exponent of their operands (so mantissas outside [1, 10) can appear),
// mul/div/pow/root/log use the order of magnitude of the result (10..99 stay plain, below 1 uses an exponent).
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add: 1 + 1e3 (from the existing tests)
  num("1.001e3"),
  // 2: add: 1e1 + 1e2
  num("1.1e2"),
  // 3: add: 1000 + 1e2
  num("11.00e2"),
  // 4: add: 1 + 1e-1
  num("1.1"),
  // 5: add: 1 + 1e-2
  num("1.01"),
  // 6: add: 1e-3 + 1e-2
  num("1.1e-2"),
  // 7: add: 6e2 + 6e2
  num("12e2"),
  // 8: add: 2.5e-1 + 7.5e-1 stays in e-1
  num("10.00e-1"),
  // 9: sub: 1.0 km - 5.0 m
  zi.m("0.995e3"),
  // 10: mul: rounding up to the next power of ten in exponent notation
  num("1.00e-2"),
  // 11: mul: rounding up to the next power of ten (3.0e2)
  num("3.0e2"),
  // 12: sin of a small angle
  num("0.010"),
)
