#' dms2dd
#' @description Convert numeric coordinate vectors in degrees, minutes, and seconds to decimal degrees
#' @param x numeric vector of length 3 corresponding to degrees, minutes, and seconds
#' @export
#' @examples
#' dt <- rbind(c(25, 12, 53.66), c(-80, 32, 00.61))
#' apply(dt, 1, function(x) dms2dd(x))
dms2dd <- function(x) {
  if (x[1] > 0) {
    x[1] + x[2] / 60 + x[3] / 60 / 60
  } else {
    x[1] - x[2] / 60 - x[3] / 60 / 60
  }
}

#' tidy_lake_df
#' @param lake data.frame output of get_lake_wiki
#' @importFrom stringr str_extract
tidy_lake_df <- function(lake) {
  lake <- rbind(c("Name", colnames(lake)[1]), lake)
  res  <- list_to_df(lake)

  res <- tidy_coordinates(res)
  res <- tidy_depths(res)
  res <- rm_line_breaks(res)
  res <- tidy_units(res)

  res
}

list_to_df <- function(ll) {
  df_names <- ll[, 1]
  df <- as.data.frame(t(ll[, -1]), stringsAsFactors = FALSE)
  colnames(df) <- df_names
  df
}

get_content <- function(lake_name) {
  res <- WikipediR::page_content("en", "wikipedia", page_name = lake_name,
    as_wikitext = FALSE)
  res <- res$parse$text[[1]]
  res <- xml2::read_html(res, encoding = "UTF-8")
  res
}

is_redirect <- function(res) {
  length(
    grep("redirect",
      rvest::html_attr(rvest::html_nodes(res, "div"), "class"))
  ) >  0
}

page_redirect <- function(res) {
  rvest::html_attr(rvest::html_nodes(res, "a"), "title")[1]
}

is_not_lake_page <- function(res, meta_index) {
  no_meta_index <- length(meta_index) == 0
  if (no_meta_index) meta_index <- 1
  res <- rvest::html_table(res[meta_index])[[1]]

  no_meta_index & !any(suppressWarnings(stringr::str_detect(unlist(res),
    c("lake",
      "tributaries",
      "outflow",
      "elevation",
      "coordinates"))))
}

tidy_coordinates <- function(res) {
  lat <- as.numeric(strsplit(res$Coordinates, ",")[[1]][1])
  lon <- as.numeric(strsplit(res$Coordinates, ",")[[1]][2])
  res$Lat <- lat
  res$Lon <- lon
  res[, !(names(res) %in% c("Coordinates", "- coordinates"))]
}

tidy_depths <- function(res) {
  depth_col_pos <- grep("depth", names(res))
  depths <- res[, depth_col_pos]

  if (length(depths) > 0) {
    has_meters <- grep("m", depths)
    is_meters_first <- stringr::str_locate(depths[has_meters], "m")[1] <
      max(stringr::str_locate(depths[has_meters], "ft")[1],
        stringr::str_locate(depths[has_meters], "feet")[1],
        na.rm = TRUE)

    if (is_meters_first) {
      depths[has_meters] <- stringr::str_extract(depths[has_meters],
        "(?<=).*\\sm")
    } else {
      depths[has_meters] <- stringr::str_extract(depths[has_meters],
        "(?<=\\().*\\sm")
    }

    # depths[has_meters] <- sapply(depths[has_meters], function(x)
    #   substring(x, 1, nchar(x) - 2))

    # missing_meters <- which(!(1:length(depths) %in% has_meters))

    res[, depth_col_pos] <- depths
  }

  res
}

drop_trailing_line_break <- function(x) {
  # x <- "asdf\nlp\noi"
  first_break <- stringr::str_locate(pattern = "\n", x)[1]
  if (substring(x, first_break - 1, first_break - 1) == ",") {
    first_break <- first_break - 1
  }

  substring(x, 1, (first_break - 1))
}

rm_line_breaks <- function(res) {
  bad_cols       <- as.logical(apply(res, 2, function(x) length(grep("\n", x) > 0)))
  res[, bad_cols] <- sapply(res[, bad_cols], drop_trailing_line_break)

  res
}

# 0 = no choice, 1 = first choice, 2 = second choice
# pull_units(res$`Surface area`, 2)
# pull_units(res$`Water volume`, 0)
# pull_units(res$`Water volume`, 1)
# pull_units(res$`Water volume`, 2)
# pull_units(res$`Average depth`, 0)
# pull_units(res$`Max. length`, 0)
# pull_units(res$`Residence time`, 0)
# pull_units(res$`Residence time`, 1)
# pull_units(res$`Residence time`, 2)

pull_units <- function(x, position) {

  x <- gsub("\\[\\d+\\]", "", x) # remove reference designations
  if (length(grep("\\d", x)) == 0) {
    position <- 3 # non-numeric result
  }
  if (nchar(x) > 0) {
    x <- stringr::str_replace_all(x, "^[^\\d]+", "") # remove preappended qualifier text
  }

  if (position == 0) {
    paren_pos <- stringr::str_locate_all(x, "\\(")[[1]][, 1]
    if (length(paren_pos) == 0) paren_pos <- nchar(x) + 2
    space_pos <- stringr::str_locate_all(x, " ")[[1]][, 1]
    x <- substring(x, space_pos[1] + 1, paren_pos[1] - 2)
  }
  if (position == 1) {
    paren_pos <- stringr::str_locate_all(x, "\\(")[[1]][, 1]
    space_pos <- stringr::str_locate_all(x, " ")[[1]][, 1]
    x <- substring(x, space_pos[1] + 1, paren_pos[1] - 2)
  }
  if (position == 2) {
    space_pos <- stringr::str_locate_all(x, " ")[[1]][, 1]
    x <- substring(x, space_pos[length(space_pos)] + 1, nchar(x) - 1)
  }
  x
}

# 0 = no choice, 1 = first choice, 2 = second choice
# pull_position(res$`Surface area`, 2)
# pull_position(res$`Water volume`, 0)
# pull_position(res$`Water volume`, 1)
# pull_position(res$`Water volume`, 2)
pull_position <- function(x, position) {

  x <- gsub("\\[\\d+\\]", "", x) # remove reference designations
  x <- stringr::str_replace_all(x, "^[^\\d]+", "") # remove preappended qualifier text

  if (position == 0) {
    paren_pos <- stringr::str_locate_all(x, "\\(")[[1]][, 1]
    if (length(paren_pos) == 0) paren_pos <- nchar(x) + 2
    space_pos <- stringr::str_locate_all(x, " ")[[1]][, 1]
    x <- substring(x, 1, paren_pos[1] - 2)
  }
  if (position == 1) {
    paren_pos <- stringr::str_locate_all(x, "\\(")[[1]][, 1]
    space_pos <- stringr::str_locate_all(x, " ")[[1]][, 1]
    x <- substring(x, 1, paren_pos[1] - 2)
  }

  if (position == 2) {
    space_pos <- stringr::str_locate_all(x, " ")[[1]][, 1]
    x <- substring(x, space_pos[length(space_pos) - 1] + 2, nchar(x) - 1)
  }
  x
}

#' Parse string representation of units package quantities
#'
#' @param x character string with unit in brackets
#' @param target_unit target unit to convert to. optional
#'
#' @export
#' @importFrom units as_units
#' @examples
#' x <- "1 [m]"
#' x <- "8.5 [m]"
#' parse_unit_brackets(x, "feet")
parse_unit_brackets <- function(x, target_unit = NA) {
  if (is.na(x)) {
    return(NA)
  }

  num_string <- strsplit(x, " ")[[1]][1]

  units_string <- strsplit(x, " ")[[1]][2:length(strsplit(x, " ")[[1]])]
  units_string <- gsub("\\[", "", units_string)
  units_string <- gsub("\\]", "", units_string)

  res <- tryCatch(units::as_units(as.numeric(num_string), units_string),
    warning = function(w) return(NA),
    error = function(e) return(NA))

  if (!is.na(target_unit)) {
    res <- tryCatch(units::set_units(res, target_unit, mode = "standard"),
      error = function(e) NA)
  }

  res
}
