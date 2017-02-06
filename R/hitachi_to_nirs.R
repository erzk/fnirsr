#' Load the data from a nirs file
#'
#' @param x A Hitachi fNIRS file.
#'
#' @return A .nirs file.
#' @export
#'
#' @references \url{https://www.nitrc.org/projects/hitachi2nirs/}
#'
#' @examples
#' hitachi_to_nirs("....csv")
#'
hitachi_to_nirs <- function(x) {
  if (file_ext(x) != "csv")
    stop("The file to convert should have a csv extension.")

}
