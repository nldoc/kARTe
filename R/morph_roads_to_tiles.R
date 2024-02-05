

morph_roads_to_tiles <- function(roads) {

  # Morph road lines to polygons by creating a. bbox polygon and splitting it into parts
  roads_bb <- st_as_sfc(st_bbox(roads$osm_lines))
  roads_poly <- lwgeom::st_split(roads_bb, roads$osm_lines) %>%
    st_sf %>%
    st_cast

  return(roads_poly)
}
