#' map_lake_wiki
#' @param res data.frame output of get_lake_wiki
#' @param ... arguments passed to maps::map
#' @importFrom maps map
#' @importFrom sp coordinates
#' @importFrom graphics points
#' @examples \dontrun{
#' map_lake_wiki(get_lake_wiki("Corey Lake"), "usa")
#'
#' map_lake_wiki(get_lake_wiki("Lake Nipigon"), regions = "Canada")
#' }
map_lake_wiki <- function(res, ...){

  coords <- as.numeric(strsplit(res[which(res[,1] == "Coordinates"), 2],
                                ",")[[1]])
  res <- data.frame(matrix(rev(coords), ncol = 2))
  sp::coordinates(res) <- ~X1 + X2

  maps::map(...)
  points(res, col = "red", cex = 1.5, pch = 19)
}
