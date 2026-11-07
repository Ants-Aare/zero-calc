/// [skip]
// BUG: zcalc.neg of a zero quantity/num stores the wrong float.
//
// operations.neg flips info.sign *before* calling as-float(term). For terms without a
// `float` field (anything coming from zi.* / num(), where `raw` is a string) as-float then reads the
// already flipped sign and the result is negated twice. The displayed sign is right, but every
// following operation sees the positive value.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: stored float of neg(m)
  zi.m("-5.0"),
  // 2: neg(m) + m
  zi.m("-4.0"),
  // 3: neg(num) + 1
  num("-4.0"),
  // 4: neg(m) * m
  zi.declare("m^2")("-10"),
  // 5: neg(num with uncertainty) * 2
  num("-10+-0.2"),
  // 6: m - neg(m)
  zi.m("6.0"),
)
