/// [skip]
// BUG: named arguments of the first operand override those given at the call site.
//
// `args.named() + datas.first().args.named()` lets the formatting of the first operand win over the
// explicit `exponent:` / `round:` argument of the call. Arguments of all other operands are ignored.
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases, check
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: exponent given at the call site
  zcalc.mul(num("1.0e4", exponent: "sci"), "2.0", exponent: "eng"),
  // 2: add: call site wins
  zcalc.add(zi.m("1.0e4", exponent: "sci"), zi.m("2.0e4"), exponent: "eng"),
  // 3: round given at the call site
  zcalc.mul(num("1.234", round: (precision: 3, mode: "figures")), "2.0", round: (precision: 1, mode: "figures")),
)
