#' Average the epoched ETG-4000 data
#'
#' @import dplyr
#'
#' @param x A data frame with an ETG-4000 data.
#' @param start_epoch A numeric. Number of samples before the trigger. Start of the epoch. The same as in epoch_ETG4000().
#' @param end_epoch A numeric. Number of samples after the trigger. End of the epoch. The same as in epoch_ETG4000().
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#' rawData <- load_ETG4000_data(file_path, ETG_header)
#' df_epochs <- epoch_ETG4000(rawData, 1, -100, 100) # use to explore the epoch quality
#' df_epochs_average <- epoch_ETG4000_average(df_epochs, -100, 100)
#'
epoch_ETG4000_average <- function(x, start_epoch, end_epoch) {
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 epochs.")
  start_epoch <- abs(start_epoch)
  end_epoch <- abs(end_epoch)

  sampled_epochs <- start_epoch + end_epoch + 1
  channels_number <- length(names(select(x, starts_with("CH")))) + 1
  x$EpochSample <- 1:sampled_epochs
  x %>%
    select(starts_with("CH"), Mark, EpochSample) %>%
    group_by(EpochSample) %>%
    summarise_each(funs(mean), 1:channels_number) %>% # TODO use summarise_all
    select(-EpochSample) %>% # TODO add Time
    return()
}
