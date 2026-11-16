// undefined and infinite results: displayed like any result, flagged in their dictionary (ordinary results have no such keys),
// and the history of the calculation is kept. (Using them in another calculation fails, which cannot be tested here.)
#import "/src/zero-calc.typ": *
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)
#let data(x) = impl.utility.retrieve-metadata(x)
#let flags(x) = {
  let d = data(x)
  repr((undefined: d.at("undefined", default: "-"), infinite: d.at("infinite", default: "-")))
}
#let method = display.method.with(show-result: false)

#cases(
  // 1: ordinary result has neither key
  [#flags(zcalc.div("1.0", "3.0"))],
  // 2: division by zero
  [#flags(zcalc.div("1", "0"))],
  // 3: tan pole
  [#flags(zcalc.tan(zi.degree("90")))],
  // 4: positive overflow
  [#flags(zcalc.mul("1e300", "1e300"))],
  // 5: negative overflow keeps its sign in the number
  [#data(zcalc.mul("1e300", "-1e300")).info.sign],
  // 6: the constant inf
  [#flags(zcalc.inf)],
  // 7: a constant is not flagged
  [#flags(zcalc.pi)],
  // 8: the history of an undefined result is kept
  [#repr(data(zcalc.div("1", "0")).source.head)],
  // 9: the operands as well
  [#data(zcalc.div("1", "0")).source.data.value.map(x => x.info.int).join(",")],
  // 10: the calculation of an undefined result can be shown
  method(zcalc.div("1", "0")),
  // 11: with its result
  display.method(zcalc.div("1", "0")),
  // 12: the calculation of an infinite result
  display.method(zcalc.mul("1e300", "1e300")),
  // 13: the value on its own
  display.variable(zcalc.div("1", "0")),
  // 14: the uncertainty on its own
  display.error(zcalc.div("1", "0")),
  // 15: error-method of an undefined result
  display.error-method(zcalc.div("1", "0")),
  // 16: in an equation the whole calculation is undefined, the parts are kept
  [#flags(equation.define($a / b + c$)(a: 1, b: 0, c: 2))],
  // 17: its history reaches down to the division
  method(equation.define($a / b + c$)(a: 1, b: 0, c: 2)),
  // 18: sqrt of a negative number
  [#flags(zcalc.sqrt("-4"))],
  // 19: the display of a defined result next to it is unchanged
  display.variable(zcalc.div("1.0", "4.0")),
)
