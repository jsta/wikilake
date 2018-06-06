#' dms2dd
#' @description Convert numeric coordinate vectors in degrees, minutes, and seconds to decimal degrees
#' @param x numeric vector of length 3 corresponding to degrees, minutes, and seconds
#' @export
#' @examples
#' dt <- rbind(c(25,12,53.66),c(-80,32,00.61))
#' apply(dt, 1, function(x) dms2dd(x))
dms2dd <- function(x){
  if(x[1] > 0){
    x[1] + x[2]/60 + x[3]/60/60
  }else{
    x[1] - x[2]/60 - x[3]/60/60
  }
}

#' tidy_lake_df
#' @param lake data.frame output of get_lake_wiki
#' @importFrom stringr str_extract
tidy_lake_df <- function(lake){
  lake <- rbind(c("Name", colnames(lake)[1]), lake)
  res  <- list_to_df(lake)

  # tidy coordinates
  lat <- as.numeric(strsplit(res$Coordinates, ",")[[1]][1])
  lon <- as.numeric(strsplit(res$Coordinates, ",")[[1]][2])
  res$Lat <- lat
  res$Lon <- lon
  res <- res[,!(names(res) %in% c("Coordinates", "- coordinates"))]

  # tidy depths
  depth_col_pos <- grep("depth", names(res))
  depths <- res[,depth_col_pos]

  if(length(depths) > 0){

    has_meters <- grep("m", depths)
    is_meters_first <- stringr::str_locate(depths[has_meters], "m")[1] <
                       max(stringr::str_locate(depths[has_meters], "ft")[1],
                           stringr::str_locate(depths[has_meters], "feet")[1],
                           na.rm = TRUE)

    if(is_meters_first){
      depths[has_meters] <- stringr::str_extract(depths[has_meters],
                                                 "(?<=).*\\sm")
    }else{
      depths[has_meters] <- stringr::str_extract(depths[has_meters],
                                                 "(?<=\\().*\\sm")
      }

    depths[has_meters] <- sapply(depths[has_meters], function(x)
                          substring(x, 1, nchar(x) - 2))

    missing_meters <- which(!(1:length(depths) %in% has_meters))

    res[,depth_col_pos] <- depths
  }

  res
}

list_to_df <- function(ll){
  df_names <- ll[,1]
  df <- as.data.frame(t(ll[,-1]), stringsAsFactors = FALSE)
  colnames(df) <- df_names
  df
}

get_content <- function(lake_name){
  res <- WikipediR::page_content("en", "wikipedia", page_name = lake_name,
                                 as_wikitext = FALSE)
  res <- res$parse$text[[1]]
  res <- xml2::read_html(res, encoding = "UTF-8")
  res
}

is_redirect <- function(res){
  length(
    grep("redirect",
         rvest::html_attr(rvest::html_nodes(res, "div"), "class"))
  ) >  0
}

page_redirect <- function(res){
  rvest::html_attr(rvest::html_nodes(res, "a"), "title")[1]
}

is_not_lake_page <- function(res, meta_index){
  no_meta_index <- length(meta_index) == 0
  if(no_meta_index) meta_index <- 1
  res <- rvest::html_table(res[meta_index])[[1]]

  no_meta_index & !any(suppressWarnings(stringr::str_detect(unlist(res),
                                                            c("lake",
                                                              "tributaries",
                                                              "outflow",
                                                              "elevation",
                                                              "coordinates"))))
}
