

#' get_box
#' @param location character
#' @param bbox numeric vector (xmin, xmax, ymin, ymax)
#'
#' @export
#' @return bbox object containg bounding box coordinates in the order ymin, xmin, ymax, xmax
get_box <- function(location,
                    bbox) {

  if (is.null(location)) {
    if (is.null(bbox)) {
      stop("Either location or bbox need to be defined!")
    }
    box <- osmdata::opq(c(xmin=bbox[1], ymin=bbox[3], xmax=bbox[2], ymax=bbox[4]))
  } else {
    box <- osmdata::opq(bbox = location)
  }

  return(box)
}
