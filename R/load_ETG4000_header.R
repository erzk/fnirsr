#' Load the ETG-4000 data
#'
#' @importFrom readr read_lines
#' @importFrom tools file_ext
#'
#' @param x Raw csv file.
#'
#' @return A vector.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' load_ETG4000_header(file_path)
#'
load_ETG4000_header <- function(x){
  if (file_ext(x) != "csv")
    stop("ETG-4000 files should have a csv extension.")
  else {
    hdr <- list()
    class(hdr) <- "fnirsHeader"
    hdr$x <- basename(x)
    line <- 0L # find the last line that doesn't start with `Data` or is blank
    input <- "start"
    while (!grepl("Data", input) & input != "") {
      line <- line + 1L
      input <- read_lines(x, skip = line - 1L, n_max = 1L)
    }
    a_hdr <- read_lines(x, skip = 1L, n_max = line - 1L)
    a_hdr <- as.list(a_hdr)
    return(a_hdr)
  }
}
