

load_gfont <- function(gfont_name,
                       gfont_width) {

  if (is.null(gfont_width)) {
    font_add_google(name = gfont_name, family = gfont_name)
  } else {
    font_add_google(name = gfont_name, family = gfont_name, regular.wt = gfont_width)
  }
  showtext::showtext_auto()
}
