#' Load the ETG-4000 data
#'
#' @param x Raw csv file.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' load_ETG4000_data(file_path)
#'
load_ETG4000_data <- function(x) {
  if (file_ext(x) != "csv")
    stop("ETG4000 files should have a csv extension.")
  dat <- read.csv(x, skip = 40) # TODO check if the number of rows vary
  # TODO read the sampling period from the header
  sampling_period <- 0.1
  dat$Time <- seq(from = 0, to = (nrow(dat) * sampling_period) - sampling_period, by = sampling_period)
  return(dat)
}
