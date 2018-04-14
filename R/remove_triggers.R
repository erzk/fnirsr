#' Remove triggers from the ETG-4000 data
#'
#' @param x A data frame with an ETG-4000 data.
#' @param trigger An integer representign a trigger/marking to remove.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#' ETG_data <-load_ETG4000_data(file_path, ETG_header)
#' ETG_data_cleaned <- remove_triggers(ETG_data, 1)
#'
remove_triggers <- function(x, trigger = NULL) {
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  if (missing(trigger))
    stop("Please provide a trigger/mark) to be removed.")
  if (!("Mark" %in% names(x)))
    stop("There is no Mark column in the provided data frame.")
  if (length(which(x$Mark == trigger)) == 0) {
    stop("Provided trigger is not in the data set.")
  } else {
  trigger_pos <- which(x$Mark == trigger)
  x[trigger_pos,] <- 0
  return(x)
  }
}
