

get_box <- function(location,
                    bbox) {

  if (is.null(location)) {
    if (is.null(bbox)) {
      stop("Either location or bbox need to be defined!")
    }
    box <- opq(c(xmin=bbox[1], ymin=bbox[3], xmax=bbox[2], ymax=bbox[4]))
  } else {
    box <- opq(bbox = location)
  }

  return(box)
}
