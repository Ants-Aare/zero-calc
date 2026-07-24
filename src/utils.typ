#let as-float(metadata) = {
  if metadata.at("float", default: none) != none {
    metadata.float
  } else if metadata.raw != none and (type(metadata.raw) == int or type(metadata.raw) == float) {
    metadata.raw
  } else {
    impl.utility.info-to-float(metadata.info)
  }
}
#let as-uncertainty(metadata) = {
  if metadata.at("uncertainty", default: none) != none {
    metadata.uncertainty
  } else {
    impl.utility.info-to-uncertainty(metadata.info)
  }
}
