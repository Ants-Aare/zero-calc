/// [skip]
// BUG: an input that is only zeros ("0.0") counts as 0 significant figures, so the result is rounded to nothing.
//
// get-sig-figs strips leading zeros and counts what is left, which is nothing for "0" and "0.0".
// The result is then rounded to 0 digits: cos(0.0) shows `0` (value 1) and acos(0.0) shows `100` (value 90).
// Zero itself is fine (`0 * 5` is `0`), but results derived from a zero input should keep at least one digit.
// (The expected strings below assume `0.0` is read as 2 significant figures; `1` / `9e1` would be acceptable for `0` or one-digit inputs.)
#import "@preview/zero:0.7.1": *
#import "/tests/helpers.typ": cases
#set page(width: auto, height: auto, margin: .5em)

#cases(
  // 1: cos(0.0)
  num("1.0"),
  // 2: cos(0.0 deg)
  num("1.0"),
  // 3: exp(0.0)
  num("1.0"),
  // 4: 5.0 ^ 0.0
  num("1.0"),
  // 5: acos(0.0)
  zi.degree("90"),
  // 6: acos(0)
  zi.degree("90"),
)
