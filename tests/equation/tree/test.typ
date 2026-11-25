// equation.tree: a math equation as plain data, for tools that work with
// the structure of an equation instead of calculating it (e.g. fitting).
//
// Nodes: (num: 2.5), (var: "K-M"), (op: "add", args: (..)),
//        (call: "f", args: (..)) for `f(x)`.
// Result: (lhs: node or none, rhs: node, variables: names in order of
//          appearance on the right side, labels: name -> math content).
#import "/src/zero-calc.typ": *
#set page(width: auto, height: auto, margin: .5em)

#let v(name) = (var: name)
#let n(value) = (num: value)
#let op(name, ..args) = (op: name, args: args.pos())
#let rhs(eq) = equation.tree(eq).rhs

// --- arithmetic --------------------------------------------------------------
#assert.eq(rhs($a + b$), op("add", v("a"), v("b")))
#assert.eq(rhs($a + b + c$), op("add", v("a"), v("b"), v("c")))
#assert.eq(rhs($a - b$), op("sub", v("a"), v("b")))
#assert.eq(rhs($-a$), op("neg", v("a")))
#assert.eq(rhs($+a$), v("a"))
#assert.eq(rhs($a b$), op("mul", v("a"), v("b")))
#assert.eq(rhs($a dot b$), op("mul", v("a"), v("b")))
#assert.eq(rhs($a times b$), op("mul", v("a"), v("b")))
#assert.eq(rhs($a b c$), op("mul", v("a"), v("b"), v("c")))
#assert.eq(rhs($a/b$), op("div", v("a"), v("b")))
#assert.eq(rhs($(a + b) c$), op("mul", op("add", v("a"), v("b")), v("c")))
#assert.eq(rhs($a x + b$), op("add", op("mul", v("a"), v("x")), v("b")))

// --- numbers -------------------------------------------------------------------
#assert.eq(rhs($2$), n(2.0))
#assert.eq(rhs($2.5 x$), op("mul", n(2.5), v("x")))
#assert.eq(rhs($1/2 m v^2$), op("mul", op("div", n(1.0), n(2.0)), v("m"), op("pow", v("v"), n(2.0))))

// --- powers, roots, absolute values -------------------------------------------
#assert.eq(rhs($a^b$), op("pow", v("a"), v("b")))
#assert.eq(rhs($x^(b + 1)$), op("pow", v("x"), op("add", v("b"), n(1.0))))
#assert.eq(rhs($e^(-k t)$), op("pow", v("e"), op("neg", op("mul", v("k"), v("t")))))
#assert.eq(rhs($sqrt(x)$), op("sqrt", v("x")))
#assert.eq(rhs($root(3, x)$), op("root", v("x"), n(3.0)))
#assert.eq(rhs($abs(a - c)$), op("abs", op("sub", v("a"), v("c"))))
#assert.eq(rhs($|a - c|$), op("abs", op("sub", v("a"), v("c"))))
#assert.eq(rhs($b |a - c|$), op("mul", v("b"), op("abs", op("sub", v("a"), v("c")))))

// --- functions -----------------------------------------------------------------
#assert.eq(rhs($ln(x)$), op("ln", v("x")))
#assert.eq(rhs($ln x$), op("ln", v("x")))
#assert.eq(rhs($log(x)$), op("log", v("x"), n(10.0)))
#assert.eq(rhs($log_2(x)$), op("log", v("x"), n(2.0)))
#assert.eq(rhs($exp(x)$), op("exp", v("x")))
#assert.eq(rhs($sin(x) + cos(x)$), op("add", op("sin", v("x")), op("cos", v("x"))))
#assert.eq(rhs($tan(x)$), op("tan", v("x")))
#assert.eq(rhs($arcsin(x)$), op("asin", v("x")))
#assert.eq(rhs($arccos(x)$), op("acos", v("x")))
#assert.eq(rhs($arctan(x)$), op("atan", v("x")))
#assert.eq(rhs($2 log(x) + 1$), op("add", op("mul", n(2.0), op("log", v("x"), n(10.0))), n(1.0)))
// anything else written like a function call stays a call
#assert.eq(rhs($f(x)$), (call: "f", args: (v("x"),)))
#assert.eq(rhs($sinh(x + 1)$), (call: "sinh", args: (op("add", v("x"), n(1.0)),)))
#assert.eq(rhs($a(x + b)$), (call: "a", args: (op("add", v("x"), v("b")),)))

// --- names ---------------------------------------------------------------------
#assert.eq(rhs($K_M$), v("K-M"))
#assert.eq(rhs($v_max$), v("v-max"))
#assert.eq(rhs($alpha$), v("alpha"))
#assert.eq(rhs($pi$), v("pi"))
#assert.eq(rhs($Delta x$), v("Delta-x"))

// --- equations -----------------------------------------------------------------
#let t = equation.tree($v(S) = (V S)/(K_M + S)$)
#assert.eq(t.lhs, (call: "v", args: (v("S"),)))
#assert.eq(t.rhs, op("div", op("mul", v("V"), v("S")), op("add", v("K-M"), v("S"))))
#assert.eq(t.variables, ("V", "S", "K-M"))
#assert.eq(t.labels.at("K-M"), $K_M$)
#assert.eq(t.labels.at("v"), $v$)
#assert.eq(equation.tree($y = a x$).lhs, v("y"))
#assert.eq(equation.tree($a x$).lhs, none)
#assert.eq(equation.tree($a x + a$).variables, ("a", "x"))

// the tree matches what define calculates
#let tree-eval(node, vars) = {
  if "num" in node { return node.num }
  if "var" in node { return vars.at(node.var) }
  let a = node.args.map(x => tree-eval(x, vars))
  if node.op == "add" { a.sum() } else if node.op == "mul" { a.product() } else if node.op == "div" { a.at(0) / a.at(1) } else if node.op == "sub" { a.at(0) - a.slice(1).sum() } else if node.op == "log" { calc.log(a.at(0), base: a.at(1)) } else { panic(node.op) }
}
#for (eq, vars) in (($a x + b$, (a: 2, x: 3, b: 1)), ($(a + b)/c - d$, (a: 1, b: 3, c: 2, d: 0.5)), ($2 log(x) + 1$, (x: 100))) {
  assert(calc.abs(tree-eval(rhs(eq), vars) - zcalc.to-float(equation.define(eq)(..vars))) < 1e-12)
}
