/// [skip]
// BUG: named arguments of the first operand override those given at the call site.
//
// `args.named() + datas.first().args.named()` lets the formatting of the first operand win over the
// explicit `exponent:` / `round:` argument of the call. Arguments of all other operands are ignored.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: exponent given at the call site
  num("2.0e4", exponent: "eng"),
  // 2: add: call site wins
  zi.m("3.0e4", exponent: "eng"),
  // 3: round given at the call site
  num("2"),
)
