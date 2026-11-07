/// [skip]
// BUG: zcalc.neg of a zero quantity/num stores the wrong float.
//
// operations.neg flips info.sign *before* calling as-float(term). For terms without a
// `float` field (anything coming from zi.* / num(), where `raw` is a string) as-float then reads the
// already flipped sign and the result is negated twice. The displayed sign is right, but every
// following operation sees the positive value.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: stored float of neg(m)
  check(zcalc.neg(zi.m("5.0")), float: -5),
  // 2: neg(m) + m
  zcalc.add(zcalc.neg(zi.m("5.0")), zi.m("1.0")),
  // 3: neg(num) + 1
  zcalc.add(zcalc.neg(num("5.0")), "1.0"),
  // 4: neg(m) * m
  zcalc.mul(zcalc.neg(zi.m("5.0")), zi.m("2.0")),
  // 5: neg(num with uncertainty) * 2
  zcalc.mul(zcalc.neg(num("5.0+-0.1")), "2.0"),
  // 6: m - neg(m)
  zcalc.sub(zi.m("1.0"), zcalc.neg(zi.m("5.0"))),
)
