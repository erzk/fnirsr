#' Load the data from a nirs file
#'
#' @importFrom R.matlab readMat
#' @importFrom tools file_ext
#'
#' @param x A nirs file.
#'
#' @return A list.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Simple_Probe.nirs", package = "fnirsr")
#' load_nirs_data(file_path)
#'
load_nirs_data <- function(x) {
  if (file_ext(x) != "nirs")
    stop("The file to read should have a .nirs extension.")
  dat <- readMat(x)
  return(dat)
}
