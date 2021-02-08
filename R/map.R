#' map_lake_wiki
#' @param res data.frame output of get_lake_wiki
#' @param ... arguments passed to maps::map
#' @importFrom maps map
#' @importFrom sp coordinates
#' @importFrom graphics points
#' @examples \dontrun{
#' map_lake_wiki(lake_wiki("Corey Lake"), database = "usa")
#'
#' map_lake_wiki(lake_wiki("Lake Nipigon"), regions = "Canada")
#' }
map_lake_wiki <- function(res, ...){
  coords <- res[,c("Lon", "Lat")]
  res <- data.frame(as.matrix(coords))
  sp::coordinates(res) <- ~Lon + Lat

  maps::map(...)
  points(res, col = "red", cex = 1.5, pch = 19)
}
