#' Load the data from a nirs file
#'
#' @importFrom tools file_ext
#'
#' @param x A Hitachi fNIRS file.
#'
#' @return A .nirs file.
#' @export
#'
#' @references \url{https://www.nitrc.org/projects/hitachi2nirs/}
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' hitachi_to_nirs(file_path)
#'
hitachi_to_nirs <- function(x) {
  if (file_ext(x) != "csv")
    stop("The file to convert should have a csv extension.")

}
