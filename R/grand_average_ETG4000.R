#' Create a grand average of the ETG-4000 data
#'
#' @param x A data frame with ETG-4000 data.
#'
#' @return A data frame with ETG-4000 data plus an extra column including Grand Average
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#'
#' fnirs_signal <- load_ETG4000_data(file_path, ETG_header)
#' grand_average_ETG4000(fnirs_signal)
#'
grand_average_ETG4000 <- function(x){
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  x$GrandAverage <- rowMeans(x[, 2:(ncol(x) - 5)])
  return(x)
}
