
#' Clean output of lake_wiki
#'
#' Currently the only operation is to standardize the units of numeric fields.
#' See the output units with the unit_key_ function.
#'
#' @param dt output of the lake_wiki function
#'
#' @export
#' @examples \dontrun{
#' dt <- lake_wiki(c("Lake Mendota","Flagstaff Lake (Maine)"))
#' dt_clean <- lake_clean(dt)
#'
#' dt <- lake_wiki(c("Lake Mendota","Trout Lake (Wisconsin)"))
#' dt_clean <- lake_clean(dt)
#' }
lake_clean <- function(dt){
  unit_key_numeric <- dplyr::filter(unit_key_(), format == "n" & !is.na(units))
  for(i in seq_len(nrow(unit_key_numeric))){
    var <- unit_key_numeric$Variable[i]
    if(var %in% names(dt)){
      # print(var)
      dt[,var] <- sapply(dt[,var],
                           function(x) parse_unit_brackets(x, unit_key_numeric$units[i]))
    }
  }
  dt
}
