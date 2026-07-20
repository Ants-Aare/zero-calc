#let units-to-signed-pairs(units) = {
  units = units.filter(x=> x!= none)
  return (units.map(x=> x.numerator) + units.filter(x=> x.denominator != ()).map(x=> 
    x.denominator.map(y=> (y.at(0), int("-"  + y.at(1))))
  )).join()
}

#let signed-pairs-to-unit(pairs) = (numerator: pairs.filter(x=> x > 0).map(x=> str(x)).pairs(), denominator: pairs.filter(x=> x < 0).map(x=> str(-x)).pairs())

#let multiply-unit(units) = {
  units = units-to-signed-pairs(units)
  let sum = (:)
  for (unit, exponent) in units {
    let found = sum.at(unit, default:none)
    if found == none {
      sum.insert(unit, exponent)
    } else {
      sum.at(unit) = sum.at(unit) + exponent
    }
  }
  signed-pairs-to-unit(units)
}

#let invert-unit(units) = if units != none{(numerator: units.denominator, denominator:units.numerator)}

#let operate-unit(units, func: it => it) = { units.map(((n, e)) => (n, func(e))) }

// #let power-unit(units, n) = operate-unit(units, func: e => n * e)

#let root-unit(units, n) = operate-unit(units, func: e => e / n)

#let pow-unit(unit, exponent) = {
  if (unit == none) { return none }
  let pairs = units-to-signed-pairs((unit,)).map(x=> x * exponent)
  signed-pairs-to-unit(pairs)
}

#let root-unit-full(unit, n) = {
  if unit == none { return none }
  let pairs = unit-to-signed-pairs(unit)
  assert(pairs.all(((s, e)) => calc.rem(e, n) == 0), message: "Cannot take root: unit exponent not evenly divisible by root degree.")
  signed-pairs-to-unit(root-unit(..pairs, n).map(((s, e)) => (s, int(e))))
}
