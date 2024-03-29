
#' get_osm_feature
#' @param box bounding box object
#' @param key character
#' @param value character
#'

get_osm_feature <- function(box, key, value) {
  message(paste("Load", key, "..."))
  osm_feature <- box %>%
    osmdata::add_osm_feature(key = key, value=value) %>%
    osmdata::osmdata_sf() %>%
    osmdata::unique_osmdata() %>%
    osmdata::unname_osmdata_sf()

  return(osm_feature)
}
