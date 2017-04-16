#' Detrend the ETG-4000 data.
#'
#' Removes a linear trend.
#'
#' @import dplyr
#' @importFrom RSEIS detrend
#'
#' @param x A data frame with an ETG-4000 data.
#' @param type A string. Specifies the type of plot. Allowed: "all" or "single".
#' @param channel A numeric or string. If type is "single" then it has to be specified.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#'
#' fnirs_signal <- load_ETG4000_data(file_path, ETG_header)
#' plot_ETG4000(fnirs_signal)
#' fnirs_det <- detrend_ETG4000_data(fnirs_signal) # detrend all channels
#' plot_ETG4000(fnirs_det)
#'
#' plot_ETG4000(fnirs_signal, "separate", 18) # zoom on one channel to notice detrending
#' plot_ETG4000(fnirs_det, "separate", 18)
#'
#' fnirs_det_24 <- detrend_ETG4000_data(fnirs_signal, "single", 24) # detrend only one channel
#' plot_ETG4000(fnirs_det_24, "separate", 24)
#'
detrend_ETG4000_data <- function(x, type = "all", channel = NULL) {
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  if (!(type %in% c("all", "single"))) {
    stop("Please how many channels to detrend: 'all' or 'single'.")
  }
  # detrend all channels
  if (type == "all") {
    # detrend
    df_CH <- select(x, starts_with("CH"))
    df_CH <- apply(df_CH, 2, detrend)
    # replace
    CH_ind <- grepl("CH", names(x))
    x[, CH_ind] <- df_CH
    return(x)
  }
  # detrend one channel
  if (type == "single") {
    if (missing(channel)) {
      stop("Channel number to detrend is missing.")
    } else {
    CH_number <- paste0("CH", channel)
    df_CH <- x[, CH_number]
    df_CH <- detrend(df_CH)
    x[, CH_number] <- df_CH
    return(x)
    }
  }
}
