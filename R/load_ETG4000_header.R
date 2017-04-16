#' Load the ETG-4000 data
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
load_ETG4000_header <- function(fileName){
  if (file_ext(fileName) != "csv")
    stop("ETG-4000 files should have a csv extension.")
  else {
    hdr <- list()
    class(hdr) <- "fnirsHeader"
    hdr$fileName <- basename(fileName)
    line <- 0L # find the last line that doesn't start with `Data` or is blank
    input <- "start"
    while (!grepl("Data", input) & input != "") {
      line <- line + 1L
      input <- read_lines(fileName, skip = line - 1L, n_max = 1L)
    }
    a_hdr <- read_lines(fileName, skip = 1L, n_max = line - 1L)
    a_hdr <- as.list(a_hdr)
    return(a_hdr)
  }
}
