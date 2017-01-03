#' dms2dd
#' @description Convert numeric coordinate vectors in degrees, minutes, and seconds to decimal degrees
#' @param x numeric vector of length 3 corresonding to degrees, minutes, and seconds
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
