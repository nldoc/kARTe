
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

  forest <- c(
    "#715040",
    "#987653",
    "#E3C171",
    "#F0DD80",
    "#A0B993",
    "#83A573",
    "#595E58"
  )

  autumn <- c(
    "#65312E",
    "#DA5232",
    "#F09540",
    "#E3DB9A",
    "#C2AB3F",
    "#545532",
    "#193436"
  )

  rainbow <- c(
    "#612E83",
    "#094F92",
    "#1BC1DA",
    "#2EB97B",
    "#F7D735",
    "#F78929",
    "#EE4552"
  )

  jungle <- c(
    "#006847",
    "#00957D",
    "#A8D57E",
    "#FDDB81",
    "#E65C1E",
    "#570E02",
    "#27272A"
  )

  star_wars_1 <- c(
    "#D7BF78",
    "#897221",
    "#AF171E",
    "#ABBAC2",
    "#DDDEEE",
    "#891D20",
    "#92CFEA",
    "#A7291C",
    "#F9A212",
    "#B62322"
  )
  star_wars_2 <- c(
    "#D7BF78",
    "#897221",
    "#382226",
    "#70393E",
    "#E7AA44",
    "#006DB2",
    "#A9D8FE",
    "#A2A332",
    "#D7DA8E",
    "#6B6A57"
  )
  star_wars_3 <- c(
    "#D7C078",
    "#897321",
    "#535353",
    "#787878",
    "#9E2A1B",
    "#F16C28",
    "#B7DDF1",
    "#006CB2",
    "#FFA44A",
    "#E7D17F"
  )
  star_wars_4 <- c(
    "#D7BF78",
    "#F1B084",
    "#AF639E",
    "#9F5A60",
    "#0C5AA0",
    "#5F9FDD",
    "#452F10",
    "#FBFFFE",
    "#343D9B",
    "#C48447"
  )
  star_wars_5 <- c(
    "#D7C178",
    "#F0AF83",
    "#8B2239",
    "#B6211F",
    "#A2A332",
    "#D8DA90",
    "#0D1B37",
    "#3E5E7A",
    "#154F9E",
    "#172E5A"
  )
  star_wars_6 <- c(
    "#D7BF78",
    "#F1B084",
    "#1E6430",
    "#77B677",
    "#4BA941",
    "#D8F8BA",
    "#B62322",
    "#079296",
    "#007793",
    "#5E3800"
  )
  star_wars_7 <- c(
    "#D7BF78",
    "#B70000",
    "#E7250A",
    "#0087E9",
    "#59C3EF",
    "#34E6AC",
    "#00C0A9",
    "#BFAA87",
    "#AC7123",
    "#C7BCA7"
  )

  pal <- eval(parse(text = palette))

  return(pal)


}
