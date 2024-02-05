

get_osm_feature <- function(box, key, value) {
  message(paste("Load", key, "..."))
  osm_feature <- box %>%
    add_osm_feature(key = key, value=value) %>%
    osmdata_sf %>% unique_osmdata %>%
    unname_osmdata_sf()

  return(osm_feature)
}
