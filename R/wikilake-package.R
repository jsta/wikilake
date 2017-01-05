#' Scrape Wikipedia lakes metadata
#' @name wikilake-package
#' @aliases wikilake
#' @importFrom stringi stri_encode stri_trans_general
#' @import selectr
#' @docType package
#' @title Scrape Wikipedia lakes metadata
#' @author \email{stachel2@msu.edu}
NULL

#' Michigan Lakes
#'
#' Metadata of Michigan lakes scraped from Wikipedia.
#'
#' @format A data frame with 48 columns and 177 rows:
#' \itemize{
#'           \item{Name: }{lake name}
#'           \item{Location: }{location description}
#'           \item{Primary inflows: }{rivers and streams}
#'           \item{Basin countries: }{countries}
#'           \item{Surface area: }{hectares}
#'           \item{Max. depth: }{meters}
#'           \item{Surface elevation: }{meters}
#'           \item{Lat: }{decimal degrees}
#'           \item{Lon: }{decimal degrees}
#'           \item{Primary outflows: }{rivers and streams}
#'           \item{Average depth: }{meters}
#'           \item{Max. length: }{meters}
#'           \item{Max. width: }{meters}
#'           }
#' @docType data
#' @keywords datasets
#' @name milakes
NULL

