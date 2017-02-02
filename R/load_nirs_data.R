#' Load the data from a nirs file
#'
#' @param x A nirs file.
#'
#' @return A list.
#' @export
#'
#' @examples
#' load_nirs_data("Simple_Probe.nirs")
#'
load_nirs_data <- function(x) {
  if (file_ext(x) != "nirs")
    stop("The file to read should have a .nirs extension.")
  dat <- readMat(x)
  return(dat)
}
