// Variables of an equation may be functions (e.g. another equation) that are evaluated with the same variable scope.
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: acceleration * time
  zi.declare("m/s")("10"),
  // 2: kinetic energy from a given velocity
  zi.declare("kg m^2 s^-2")("3.8e3"),
  // 3: velocity variable is another equation
  zi.declare("kg m^2 s^-2")("3.8e3"),
)
