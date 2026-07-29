#import "@preview/parsely:0.1.1"
#import "arithmetic.typ"
#import "utility.typ"

#let math-to-tree(math) = {
  let (tree, rest) = parsely.parse(math, arithmetic.arithmetic)
  return tree
}

#let calculate-tree(tree, ..values) = {
  let result = parsely.walk(
    tree,
    post: it => arithmetic.apply-operations(it, values.named()),
  )
  utility.display(result)
}

#let calculate-math(math) = calculate-tree.with(math-to-tree(math))
