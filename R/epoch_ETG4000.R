#' Epoch the ETG-4000 data
#'
#' @param x A data frame with an ETG-4000 data.
#' @param trigger A code used to represent a trigger, e.g. 1.
#' @param start_epoch A numeric. Number of samples before the trigger. Start of the epoch.
#' @param end_epoch A numeric. Number of samples after the trigger. End of the epoch.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#' rawData <- load_ETG4000_data(file_path, ETG_header)
#'
#' df_epochs <- epoch_ETG4000(rawData, 1, -100, 100)
#'
epoch_ETG4000 <- function(x, trigger, start_epoch, end_epoch) {
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  start_epoch <- abs(start_epoch)
  end_epoch <- abs(end_epoch)

  trigger_indices <- which(x$Mark == trigger) # get the indices
  # TODO check the space between the triggers
  rows <- lapply(trigger_indices, function(x) (x - start_epoch):(x + end_epoch))
  x <- x[unlist(rows),]
  return(x)
}
