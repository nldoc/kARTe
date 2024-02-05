
#' get_palette
#' @param palette character
#'
get_palette <- function(palette) {

  original <- c(
    "#77AAC0",
    "#EB283B",
    "#F06344",
    "#619555",
    "#2185C6",
    "#F9C442",
    "#E32A7D"
  )


  blend <- c(
    "#9b2226",
    "#ae2012",
    "#bb3e03",
    "#ca6702",
    "#ee9b00",
    "#e9d8a6",
    "#94d2bd",
    "#0a9396",
    "#005f73"
  )


  synth <- c(
    "#f72585",
    "#b5179e",
    "#7209b7",
    "#560bad",
    "#480ca8",
    "#3a0ca3",
    "#3f37c9",
    "#4361ee",
    "#4895ef",
    "#4cc9f0"
  )


  pal <- eval(parse(text = palette))

  return(pal)


}
