# Zero-calc
Basic math operations and equation formatting for [Typst](https://typst.app).


**Zero-calc** allows you to do all your calculations inside your document with automatic **error propagation**, **unit tracking**, and **significant-figures** handled for you.

## Basic Usage

```typst
#import "@preview/zero:0.6.2": *
#import "@preview/zero-calc:0.6.2": *
#zcalc.div(m[30+-0.3], s[5+-0.4])
```

<p align="center">
<img alt="" src="https://raw.githubusercontent.com/Ants-Aare/zero-calc/0.6.2/tests/readme/ref/1.png" />
</p>

It's built directly on top of [Zero](https://typst.app/universe/package/zero) for number and quantity formatting, so make sure you use the same version number.

## Calculation History and Error Propagation
```typst
#let value = zcalc.div(m[30+-1.45], s[5.0+-0.20]) // 30 / 5 = 6
#let value = zcalc.pow(value, 2)                  // 6^2 = 36

#display.method-result(value)
#display.error-method-result(value)
```
<p align="center">
<img alt="" src="https://raw.githubusercontent.com/Ants-Aare/zero-calc/0.6.2/tests/readme/ref/2.png" />
</p>
You can use the results of operations to do further calculations. Every `zcalc` result carries its full dependency graph. `display.method-result` reconstructs that as a typeset equation showing how the value was calculated and `display.error-method-result` does the same for the uncertainty.

## Defining reusable equations
```typst
#let kinetic-energy-math = $E_"kin" = 1/2 m v^2$
#let kinetic-energy-function = equation.define(kinetic-energy-math)
#let value = kinetic-energy-function(m: g[10], v: zcalc.div(m[30], s[5.0]))

#kinetic-energy-math
#display.method-result(value)
```
<p align="center">
<img alt="" src="https://raw.githubusercontent.com/Ants-Aare/zero-calc/0.6.2/tests/readme/ref/3.png" />
</p>

Beyond basic arithmetic, **Zero-calc** also understands typst equations using [Parsely](https://typst.app/universe/package/parsely). Define equations once and call them by giving the necessary parameters.

## Modifying Equation Trees and Isolating Variables
```typst
#let kinetic-energy-tree = equation.to-tree(kinetic-energy-math)
#let velocity-tree = equation.isolate-variable(kinetic-energy-tree, $v$)

#display.display-equation(velocity-tree.first())
#equation.calculate-tree(velocity-tree, m: g[10], Ekin: g-m2-s-2[180])

```
<p align="center">
<img alt="" src="https://raw.githubusercontent.com/Ants-Aare/zero-calc/0.6.2/tests/readme/ref/4.png" />
</p>

You can parse a Typst math equation into a tree and even isolate a
variable (for simple equations). The result is a list of possible values.

## List of supported operations
- zcalc.add
- zcalc.sub
- zcalc.abs
- zcalc.neg
- zcalc.mul
- zcalc.div
- zcalc.pow
- zcalc.exp
- zcalc.root
- zcalc.sqrt
- zcalc.log
- zcalc.ln
- zcalc.sin
- zcalc.cos
- zcalc.tan
- zcalc.pi
- zcalc.e
- zcalc.tau
- zcalc.inf