#' Remove channels from the ETG-4000 data
#'
#' @param x A data frame with ETG-4000 data.
#' @param channel A vector with integers.
#'
#' @return A data frame with ETG-4000 data.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#' df <- load_ETG4000_data(file_path, ETG_header)
#'
#' remove_channels_ETG4000(df, channel = 15)
#' remove_channels_ETG4000(df, channel = c(16, 20))
#'
remove_channels_ETG4000 <- function(x, channel = NULL){
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  if (missing(channel)) {
    stop("Please provide channel numbers to be removed.")
  } else {
  channel = paste0("CH", channel)
  x <- x[ , !(names(x) %in% channel)]
  return(x)
  }
}
