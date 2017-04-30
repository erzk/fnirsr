#' Load the ETG-4000 data
#'
#' @importFrom tools file_ext
#' @importFrom utils read.csv
#' @importFrom stringr str_extract
#'
#' @param x Raw csv file.
#' @param header_ETG4000 A list representing an ETG-4000 header.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#' load_ETG4000_data(file_path, ETG_header)
#'
load_ETG4000_data <- function(x, header_ETG4000) {
  if (file_ext(x) != "csv")
    stop("ETG4000 files should have a csv extension.")
  if (!is.list(header_ETG4000))
    stop("Please provide a valid ETG4000 header.")
  dat <- read.csv(x, skip = 40) # TODO check if the number of rows varies
  # read the sampling period from the header
  sampling_element <- which(grepl("Sampling Period", header_ETG4000))
  sampling_element <- header_ETG4000[[sampling_element]]
  sampling_period <- as.numeric(str_extract(sampling_element, "\\d+\\.*\\d*"))
  dat$Time <- seq(from = 0,
                  to = (nrow(dat) * sampling_period) - sampling_period,
                  by = sampling_period)
  # TODO standardise the channel names, e.g. CH1 etc.
  return(dat)
}
