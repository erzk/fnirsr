#' Detrend the ETG-4000 data.
#'
#' Removes a linear trend.
#'
#' @param x Raw csv file.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' fnirs_signal <- load_ETG4000_data(file_path)
#' plot_ETG4000(fnirs_signal)
#' fnirs_det <- detrend_ETG4000_data(fnirs_signal)
#' plot_ETG4000(fnirs_det)
#'
#' plot_ETG4000(fnirs_signal, "separate", 18)
#' plot_ETG4000(fnirs_det, "separate", 18)
#'
detrend_ETG4000_data <- function(x) {
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  # detrend
  df_CH <- select(x, starts_with("CH"))
  df_CH <- apply(df_CH, 2, detrend)
  # replace
  CH_ind <- grepl("CH", names(x))
  x[, CH_ind] <- df_CH
  return(x)

  # TODO add an option to detrend a single channel
  # detrend channel 18: works
  # det_fnirs <- detrend(fnirs_signal$CH18)
  # plot(det_fnirs, type = "l")
}
