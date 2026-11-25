#import "@preview/zero:0.7.1"
#import "@preview/parsely:0.1.1"
#import "arithmetic.typ"
#import "utility.typ"
#import "display.typ"

// Pair bare bars `|a - c|` into abs(a - c): parsely only matches bars
// when they span the whole sequence.
#let pair-bars(body) = {
  if type(body) != content or not body.has("children") { return body }
  let is-bar(it) = type(it) == content and it.has("text") and it.text in ("|", "∣")
  let children = body.children
  // bars around the whole sequence are matched by the grammar already
  if children.filter(is-bar).len() == 2 and is-bar(children.first()) and is-bar(children.last()) { return body }
  let out = ()
  let open = none
  for child in children.map(pair-bars) {
    if is-bar(child) and open == none {
      open = out.len()
      out.push(child)
    } else if is-bar(child) {
      let inner = out.slice(open + 1)
      out = out.slice(0, open)
      out.push(math.abs(inner.join()))
      open = none
    } else {
      out.push(child)
    }
  }
  out.join()
}

#let define(math-equation) = {
  let type = type(math-equation)
  if type == content and math-equation.func() == math.equation {
    let math-equation = math.equation(block: math-equation.block, pair-bars(math-equation.body))
    let (tree, rest) = parsely.parse(math-equation, arithmetic.grammar)
    return arithmetic.calculate-tree.with(tree)
  }
}

// --- equation.tree --------------------------------------------------------------

#let leaf-name(it) = utility.to-str(it).replace(utility.invisible-symbols, "").replace(utility.illegal-symbols, "-")

#let functions = (
  ln: "ln", exp: "exp", sin: "sin", cos: "cos", tan: "tan",
  arcsin: "asin", arccos: "acos", arctan: "atan",
)

/// Convert a parsely tree into plain data. Returns (node, labels) where
/// labels is an array of (name, content) pairs for every variable.
#let to-data(node) = {
  let many(children) = {
    let nodes = ()
    let labels = ()
    for child in children {
      let (n, l) = to-data(child)
      nodes.push(n)
      labels += l
    }
    (nodes, labels)
  }
  let op(name, children) = {
    let (nodes, labels) = many(children)
    ((op: name, args: nodes), labels)
  }

  if type(node) == content {
    let text = utility.to-str(node)
    let number = text.match(utility.valid-number-regex)
    if number != none and number.start == 0 and number.end == text.len() {
      return ((num: float(text.replace(",", "."))), ())
    }
    let name = leaf-name(node)
    return ((var: name), ((name, math.equation(block: false, node)),))
  }

  let (head, args, slots) = node
  if head == "eq" { panic("an equation may only contain one `=`") }
  if head in ("pos", "group") { return to-data(if head == "pos" { args.first() } else { slots.expr }) }
  if head in ("delta", "Delta") {
    let symbol = if head == "delta" { sym.delta } else { sym.Delta }
    let name = head + "-" + leaf-name(args.first())
    return ((var: name), ((name, math.equation(block: false, symbol + args.first())),))
  }
  if head == "add" { return op("add", args) }
  if head == "sub" { return op("sub", args) }
  if head == "neg" { return op("neg", args) }
  if head in ("mul", "dot", "times") { return op("mul", args) }
  if head == "frac" { return op("div", (slots.num, slots.denom)) }
  if head == "pow" { return op("pow", args) }
  if head == "sqrt" { return op("sqrt", (slots.radicand,)) }
  if head == "root" { return op("root", (slots.radicand, slots.index)) }
  if head in ("abs", "abs-bars") { return op("abs", (slots.value,)) }
  if head == "log10" {
    let (value, labels) = to-data(args.first())
    return ((op: "log", args: (value, (num: 10.0))), labels)
  }
  if head == "log" { return op("log", (args.first(), slots.base)) }
  if head in functions { return op(functions.at(head), args) }
  if head == "call" {
    let (argument, labels) = to-data(slots.args)
    let name = leaf-name(slots.fn)
    return ((call: name, args: (argument,)), labels + ((name, math.equation(block: false, slots.fn)),))
  }
  panic("cannot convert `" + head + "` into a tree")
}

/// Variable names of a tree in order of first appearance.
#let variable-names(node) = {
  if "var" in node { return (node.var,) }
  if "args" in node { return node.args.map(variable-names).flatten().dedup() }
  ()
}

/// The structure of a math equation as plain data, e.g. for fitting:
///
///   equation.tree($v(S) = (V S)/(K_M + S)$)
///
/// gives (lhs: (call: "v", args: ((var: "S"),)), rhs: (op: "div", args: ..),
/// variables: ("V", "S", "K-M"), labels: (V: $V$, S: $S$, K-M: $K_M$, v: $v$)).
///
/// Nodes are (num: 2.5), (var: "K-M"), (op: name, args: (..)) with the ops
/// add, sub, neg, mul, div, pow, sqrt, root (radicand, index), abs, ln,
/// log (value, base), exp, sin, cos, tan, asin, acos, atan, and
/// (call: "f", args: (..)) for anything else written like `f(x)`.
/// Variable names follow `define`: $K_M$ is "K-M", $Delta x$ "Delta-x".
#let tree(math-equation) = {
  assert(
    type(math-equation) == content and math-equation.func() == math.equation,
    message: "equation.tree: expected a math equation, got " + repr(math-equation),
  )
  let math-equation = math.equation(block: math-equation.block, pair-bars(math-equation.body))
  let result = parsely.parse(math-equation, arithmetic.grammar)
  assert(result.rest == none, message: "equation.tree: could not parse " + repr(result.rest))
  let parsed = result.tree
  let (lhs, rhs) = if type(parsed) == dictionary and parsed.head == "eq" { parsed.args } else { (none, parsed) }
  let (rhs, labels) = to-data(rhs)
  if lhs != none {
    let (converted, lhs-labels) = to-data(lhs)
    lhs = converted
    labels += lhs-labels
  }
  (lhs: lhs, rhs: rhs, variables: variable-names(rhs), labels: labels.dedup(key: ((name, _)) => name).to-dict())
}
