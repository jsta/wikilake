
#' lake_wiki_browser
#' @param lake_wiki_obj data.frame output of lake_wiki
#' @param lake_names fallback character vector of lake names
#' @export
#' @examples \dontrun{
#' lake_wiki_browser(lake_names = "Lake Mendota")
#' lake_wiki_browser(lake_names = c("Lake Mendota", "Lake Champlain"))
#' lake_wiki_browser(lake_wiki(c("Lake Mendota", "Lake Champlain")))
#' }
lake_wiki_browser <- function(lake_wiki_obj = NA, lake_names = NA){
  stopifnot("Must provide either a name or a lake_wiki output object" =
              !any(is.na(lake_names)) | inherits(lake_wiki_obj, "data.frame"))
  # stopifnot("Must provide one of either a name or a lake_wiki output object" =
  #             !is.na(name) & inherits(lake_wiki_obj, "data.frame"))

  open_page <- function(x){
    page_metadata <- page_info("en","wikipedia", page = x)$query$pages
    page_link     <- page_metadata[[1]][["fullurl"]]
    utils::browseURL(page_link)
  }

  is_lake_wiki_output <- as.character(inherits(lake_wiki_obj, "data.frame"))
  lake_names <- switch(is_lake_wiki_output,
                       "FALSE" = lake_names,
                       "TRUE" = lake_wiki_obj[,"Name"])

  invisible(sapply(lake_names, open_page))
}
