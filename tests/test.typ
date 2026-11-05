#let silver-silverchloride-electrode-potential(
  standardpotential,
  temperature,
  solubilityconstant,
  activity,
) = {
  zcalc.add(
    standardpotential,
    zcalc.mul(
      zcalc.div(
        zcalc.mul(
          gas-constant,
          temperature,
        ),
        faraday-constant,
      ),
      zcalc.ln(
        zcalc.div(
          solubilityconstant,
          activity,
        ),
      ),
    ),
  )
}
#let silver-silverchloride-standard-electrode-potential(
  standardpotential,
  temperature,
  solubilityconstant,
) = {
  zcalc.add(
    standardpotential,
    zcalc.mul(
      zcalc.div(
        zcalc.mul(
          gas-constant,
          temperature,
        ),
        faraday-constant,
      ),
      zcalc.ln(solubilityconstant),
    ),
  )
}
