#import "@preview/parsely:0.1.1"
#import "operations.typ"
#import "utility.typ"
// #import "match.typ": loose, slot, tight



#let declare(
  method,
  name: auto,
) = {}

// copy pasted and modified based on parsely.common.arithmetic
#let arithmetic = (
  eq: (infix: $=$, prec: 0),

  add: (infix: $+$, prec: 1, assoc: true),
  sub: (infix: $-$, prec: 1),
  pos: (prefix: $+$, prec: 2),
  neg: (prefix: $-$, prec: 2),

  times: (infix: $times$, prec: 2, assoc: true),
  dot: (infix: $dot$, prec: 2),
  mul: (infix: none, prec: 2.5, assoc: true),

  group: (match: $(parsely.slot("expr*"))$),
  frac: (match: math.frac),
  abs: (match: math.abs),

  pow: (
    match: math.attach,
    guard: slots => "t" in slots,
    rewrite: ((slots,)) => {
      let (base, t, ..rest) = slots
      let base = if rest.len() == 0 { base } else { math.attach(base, ..rest) }
      (head: "pow", args: (base, t), slots: (:))
    },
  ),

  root: (match: math.root(parsely.slot("index", guard: it => it != none), parsely.slot("radicand"))),
  sqrt: (match: $sqrt(parsely.slot("radicand"))$),

  call: (match: $parsely.slot("fn") parsely.tight (parsely.slot("args*"))$),

  ln: (match: $ln$),
  log: (match: $log$),

  sin: (match: $sin$),
  cos: (match: $cos$),
  tan: (match: $tan$),
  // arcsin: (match: $arcsin$),
  // arccos: (match: $arccos$),
  // arctan: (match: $arctan$),
)

#let apply-operations((head, args, slots)) = {
  if head == "add" or head == "pos" {
    operations.add(args)
  } else if head == "sub" {
    operations.sub(args.first(), args.slice(1))
  } else if head == "neg" {
    operations.neg(args.first())
  } else if head == "mul" or head == "dot" or head == "times" {
    operations.mul(args)
  } else if head == "frac" {
    operations.div(slots.num, slots.denom)
  } else if head == "pow" {
    operations.pow(..args)
  } else if head == "group" {
    slots.expr
  } else if head == "sqrt" {
    operations.root(slots.radicand, utility.normalise-constant(2))
  } else if head == "root" {
    operations.root(slots.radicand, slots.index.value)
  } else {
    panic(head)
  }
}

#let valid-number-regex = regex("[+\-]?(\d+\.\d*|\d*\.\d+|\d+)([e][+\-]?\d+)?")
#let invisible-symbols = regex("[\)]")
#let illegal-symbols = regex("[,. −\(]")

#let resolve-leaf-node(it, vars) = {
  let content-to-str = utility.to-str(it)
  let variable-name = content-to-str.replace(invisible-symbols, "").replace(illegal-symbols, "-")
  let variable = vars.at(variable-name, default: none)
  let quantity = if variable == none {
    if variable-name == "e" {
      operations.e
    } else if variable-name == "tau" {
      operations.tau
    } else if variable-name == "pi" {
      operations.pi
    }
  } else if variable != none {
    operations.normalise-quantity(variable)
  }

  if (quantity == none) {
    let number-match = content-to-str.match(valid-number-regex)
    if (number-match != none) and (number-match.start == 0) and (number-match.end == content-to-str.len()) {
      quantity = operations.normalise-constant(content-to-str)
    }
  }

  if quantity == none {
    panic(
      "please consider adding a variable called \"" + variable-name + "\"",
      "cannot evaluate symbol: " + repr(it),
    )
  }
  return quantity
}

#let convert-to-leaves(it) = {
  // converts multiplying leaf "delta" with leaf "E" to a single "delta E" leaf
  for i in range(it.args.len()).rev() {
    let arg = it.args.at(i)
    if type(arg) == dictionary and arg.head == "mul" and (arg.args.at(0).at("text", default: none) == "Δ") {
      it.args.remove(i)
      it.args.push(arg.args.join([ ]))
    }
  }
  it
}
#let from-math(equation) = {
  let (tree, rest) = parsely.parse(equation, arithmetic)

  (..values) => utility.display(parsely.walk(
    tree,
    pre: convert-to-leaves,
    leaf: it => resolve-leaf-node(it, values.named()),
    post: apply-operations,
  ))
}
