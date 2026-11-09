// display.method-result: `calculation = result` as one equation.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: add
  math.equation($ #num("1.5") + #num("2.25") = #num("3.8") $),
  // 2: with uncertainty (default hides it)
  math.equation($ #num("1.5") + #num("2.5") = #num("4.0") $),
  // 3: show-error: true
  math.equation($ #num("1.5+-0.1") + #num("2.5+-0.1") = #num("4.0+-0.1") $),
  // 4: quantities
  math.equation($ #zi.m("30.0")/#zi.s("5.0") = #zi.declare("m/s")("6.0") $),
  // 5: README example
  math.equation($ (#zi.m("30.00")/#zi.s("5.00"))^2 = #zi.declare("m^2/s^2")("36.0") $),
  // 6: conversion
  math.equation($ #zi.km("1.5") times #zi.declare("m/km")("1e3", omit-unity-mantissa: true) = #zi.m("1.5e3") $),
  // 7: conversion with a compound unit
  math.equation($ #zi.km-h("3.6") times #zi.declare("m/km")("1e3", omit-unity-mantissa: true) times #zi.hour("1")/#zi.second("3600") = #zi.declare("m/s")("1.0") $),
  // 8: method-result of neg
  math.equation($ -#num("5.0") = #num("-5.0") $),
)
