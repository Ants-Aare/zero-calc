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
