#' Create a grand average of the ETG-4000 data
#'
#' @param x A data frame with ETG-4000 data.
#'
#' @return A data frame with ETG-4000 data plus an extra column including Grand Average
#' @export
#'
#' @examples
#' grand_average_ETG4000(df)
#'
grand_average_ETG4000 <- function(x){
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  x$GrandAverage <- rowMeans(x[, 2:(ncol(x) - 5)])
  return(x)
}
