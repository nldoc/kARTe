

#' Get spatial data from metrics.patches output
#'
#' @description Create kARTe
#'
#' @param location charatcer string, define a location for automatic bbox estimation.
#' If NULL (default) the provided bbox will be used instead
#' @param bbox numeric vector(xmin, xmax, ymin, ymax), define a bbox instead of a location string.
#' Only used when location == NULLs
#' @param edge_buffer numeric vector(x, y), define a buffer for x and y direction.
#' Map will be clipped by defined buffers before plotting.
#' @param river_linewidth numeric value, river linewidth in plot
#' @param roads_linewidth numeric value, roads linewidth in plot
#' @param color_palette charatcer, name of the color palette.
#' Choices are currently: "original", "blend", "synth". Alternatively,
#' Optionally, a vector with colors can be passed
#' @param color_water character, single color for water
#' @param label character, label to put below the plotting area
#' @param gfont_name character, name of a google font to use for the label
#' @param gfont_width numeric, optional width specification for google font
#' @param gfont_size numeric, label font size in plot
#' @param show_plot boolean, if TRUE (default) plot is shown in the RStudio Plots pane
#' @param export boolean, if TRUE (default) plot will be written to the define `file_format`
#' @param output_dir character, output directory for plot export
#' @param filename character, file name for plot export
#' @param timestamp boolean, if TRUE (default) a timestamp will be pasted to the defined `filename`
#' @param file_format character vector, define one or multiple file formats (e.g. c("svg", "png"))
#' @param file_width numeric, width of exported file
#' @param file_height numeric, height of exported file
#' @param file_units character, units specification for `file_width` and `file_height` , defaults to "cm"
#' @param file_dpi numeric, DPI of exported file
#'
#' @import ggplot2
#'
#' @return ggplot object
#' @details
#' Create a kARTe plot and files
#'
#' @examples
#' \dontrun{
#'
#' # Create a kARTe with bbox:
#' xmin=9.871
#' xmax=9.971
#' ymin=51.51
#' ymax=51.57
#'
#' bbox = c(xmin, xmax, ymin, ymax)
#' edge_buffer = c(0.01, 0.005)
#'
#' create_kARTe(bbox = bbox,
#'              edge_buffer = edge_buffer,
#'              label = "GÖTTINGEN",
#'              gfont_width = 500,
#'              output_dir = "",
#'              filename = "map")
#'
#'  # Create a kARTe with location name
#' create_kARTe(location = "Göttingen",
#'              edge_buffer = edge_buffer,
#'              label = "GÖTTINGEN",
#'              gfont_width = 500,
#'              output_dir = "",
#'              filename = "map")
#' }
#'
#' @export
create_kARTe <- function(location = NULL,
                         bbox = NULL,
                         edge_buffer = 0,
                         river_linewidth = 10,
                         roads_linewidth = 2,
                         color_palette = "original",
                         color_water = "black",
                         label = "",
                         gfont_name = "Lexend",
                         gfont_width = NULL,
                         gfont_size = 60,
                         show_plot = TRUE,
                         export = TRUE,
                         output_dir = "",
                         filename = "map",
                         timestamp = TRUE,
                         file_format = c("svg", "png"),
                         file_width = 80,
                         file_height = 80,
                         file_units = "cm",
                         file_dpi = 300) {


  ## this script/image is inspired by:
  # https://www.juniqe.de/amsterdam-premium-poster-1x1-4737514.html#step=material&productId=4737533&frameId=349


  ## TODO: ASSERTIONS!

  ## Load gfont:
  load_gfont(gfont_name, gfont_width)

  ## Load bounding box
  box <- get_box(location, bbox)

  ## Administrative boundaries:
  boundaries <- get_osm_feature(box = box,
                                key = 'admin_level',
                                value="11")

  ## Water
  water <- get_osm_feature(box = box,
                           key = "natural",
                           value = c("water", "river"))


  river <- get_osm_feature(box = box,
                           key = "waterway",
                           value = "river")

  ## Roads
  roads <- get_osm_feature(box = box,
                           key = 'highway',
                           value = NULL)

  # Morph road lines to polygons by creating a. bbox polygon and splitting it into parts
  roads_poly <- morph_roads_to_tiles(roads)

  ## Plot limits including buffer
  box_limits <- as.numeric(strsplit(box$bbox, ",")[[1]])


  xlim <- c(box_limits[2] + edge_buffer[1], box_limits[4] - edge_buffer[1])
  ylim <- c(box_limits[1] + edge_buffer[2], box_limits[3] - edge_buffer[2])

  # Color palette
  if (length(color_palette == 1)) {
    palette <- get_palette(color_palette)
  } else {
    palette <- color_palette
  }

  # Prepare plot
  n_poly_colors = length(palette)
  roads_poly$id = as.factor(as.numeric(rownames(roads_poly)) %% n_poly_colors)

  ## Plot
  kARTe <- ggplot() +
    geom_sf(data=roads_poly, aes(fill=id)) +
    geom_sf(data=river$osm_multilines, color=color_water, fill=color_water, linewidth=river_linewidth) +
    geom_sf(data=water$osm_multipolygons, color=color_water, fill=color_water) +
    geom_sf(data=roads$osm_lines, linewidth=roads_linewidth) +
    coord_sf(xlim, ylim) +
    scale_fill_manual(values=palette) +
    xlab(label) +
    theme(legend.position="none",
          axis.title.y=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x = element_text(hjust = 0, vjust=0, family=gfont_name, size=gfont_size),
          plot.margin = margin(t = 5, r = 5, b = 5, l = 5, unit = "mm"))

  if (show_plot) {
    kARTe
  }

  if (export) {
    if (!dir.exists(output_dir)) {
      stop("Defined output dir does not exist!")
    }
    # Add timestamp
    if (timestamp) {
      filename <- paste0(filename, gsub(" |:|\\.|-", "_", Sys.time()))
    }

    purrr::walk(file_format, function(f) {
      filename_ext <- paste0(filename, ".", f)
      ggsave(file=filename_ext,
             path = output_dir,
             plot = kARTe,
             height=file_height,
             width=file_width,
             units=file_units,
             dpi = file_dpi)

      if (file.exists(file.path(output_dir, filename_ext))) {
        message(paste("File", filename_ext, "has been created successfully!"))
      } else {
        message(paste("File", filename_ext, "could not be saved on local disk!"))
      }
    })
  }

  return(kARTe)

}



