// equation.define: how math is parsed. Function names bind to their
// argument only (like ln), operator names (exp, max, ...) are readable
// anywhere, and |...| works inside larger expressions.
#import "/src/zero-calc.typ": *
#set page(width: auto, height: auto, margin: .5em)

#let expect(eq, want, ..vars) = {
  let got = zcalc.to-float(equation.define(eq)(..vars))
  assert(
    calc.abs(got - want) <= 1e-9 * calc.max(1, calc.abs(want)),
    message: repr(eq) + " with " + repr(vars.named()) + ": expected " + repr(want) + ", got " + repr(got),
  )
}

// --- precedence: functions apply to their argument, not to the rest -----
#expect($log(x) + b$, 3, x: 100, b: 1)
#expect($log x + b$, 3, x: 100, b: 1)
#expect($2 log(x) + 1$, 5, x: 100)
#expect($log(x) b$, 6, x: 100, b: 3)
#expect($b + log(x)$, 3, x: 100, b: 1)
#expect($sin(x) + b$, 1, x: 0, b: 1)
#expect($cos(x) + b$, 2, x: 0, b: 1)
#expect($tan(x) + b$, 1, x: 0, b: 1)
#expect($2 sin(x) + 1$, 1, x: 0)
#expect($sin(x) + cos(x)$, 1, x: 0)
#expect($arcsin(x) + arccos(x)$, 90, x: 0)
#expect($arctan(x) + arctan(y)$, 45, x: 1, y: 0)
// unchanged: ln and log with a base already bound tightly
#expect($ln(x) + b$, 1, x: 1, b: 1)
#expect($ln(x) b$, 2, x: calc.e, b: 2)
#expect($log_2(x) + 1$, 4, x: 8)
// a function of a sum still needs parentheses around the sum
#expect($log(x + b)$, 2, x: 99, b: 1)
#expect($sin(x + b)$, 0, x: 0, b: 0)

// --- operator names: exp, and names like v_max, x_min -------------------
#expect($exp(x)$, calc.e, x: 1)
#expect($exp(-x)$, 1 / calc.e, x: 1)
#expect($2 exp(x) + 1$, 3, x: 0)
#expect($exp(x) + exp(y)$, 2, x: 0, y: 0)
#expect($v_max x$, 6, v-max: 2, x: 3)
#expect($x_max - x_min$, 4, x-max: 5, x-min: 1)
#assert.eq(impl.utility.to-str($exp$.body), "exp")
#assert.eq(impl.utility.to-str($v_max$.body), "v-max")
#assert.eq(impl.utility.to-str($K_M$.body), "K-M")

// --- absolute values with bars inside larger expressions ----------------
#expect($|a|$, 6, a: -6)
#expect($abs(a)$, 6, a: -6)
#expect($abs(a - c)$, 3, a: 1, c: 4)
#expect($|a - c|$, 3, a: 1, c: 4)
#expect($abs(a b - c)$, 2, a: 1, b: 2, c: 4)
#expect($b abs(a)$, 12, a: -6, b: 2)
#expect($b |a - c|$, 6, a: 1, b: 2, c: 4)
#expect($|a - c| b$, 6, a: 1, b: 2, c: 4)
#expect($|a| + |c|$, 3, a: -1, c: -2)
#expect($1 + |a|$, 7, a: -6)
#expect($abs(a - c) b$, 6, a: 1, b: 2, c: 4)
