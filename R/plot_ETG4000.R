#' Plot the raw signal
#'
#' @import dplyr
#' @import zoo
#' @importFrom graphics abline
#' @importFrom graphics lines
#' @importFrom graphics plot
#'
#' @param x A data frame with an ETG-4000 data.
#' @param type A string. Specifies the type of plot.
#' Options: "facets", "overlap", "separate", "average". Defaults to "facets".
#' @param channel An integer. Represents the channel number.
#'
#' @return A plot.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#' rawData <- load_ETG4000_data(file_path, ETG_header)
#'
#' plot_ETG4000(rawData)
#' plot_ETG4000(rawData, type = "overlap")
#' plot_ETG4000(rawData, type = "separate", channel = 1)
#'
#' averagedData <- grand_average_ETG4000(rawData)
#' plot_ETG4000(averagedData, type = "average")
#'
plot_ETG4000 <- function(x, type = "facets", channel = NULL) {
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  if (!(type %in% c("facets", "overlap", "separate", "average"))) {
    stop("Type of plot incorrect. Allowed: 'facets', 'overlap', 'separate', or 'average'.")
  }

  event_lines <- x %>% dplyr::filter(Mark > 0) %>% .[[1]]
  event_lines_time <- x %>% dplyr::filter(Mark > 0) %>% .$"Time"

  x_zoo <- zoo(x[, 2:(ncol(x) - 5)])

  if (type == "facets") {
    my.panel <- function(y, ...) {
      lines(y, ...)
      abline(v = event_lines, col = "red")
    }

    plot.zoo(x_zoo, ylim = c(min(x_zoo), max(x_zoo)),
             xlab = "Samples", main = "All channels", panel = my.panel)
  }
  if (type == "overlap") {
    plot(x_zoo, screens = 1, col = 1:ncol(x_zoo),
         xlab = "Samples", ylab = "Intensity", main = "All channels")
    # TODO add abline
  }
  if (type == "separate") {
    if (missing(channel)) {
      stop("Channel number to plot is missing.")
    } else {
      channel = paste0("CH", channel)
      plot(x$Time, x[[channel]], type = "l",
           xlab = "Time (s)", ylab = "Intensity",
           main = paste0("Channel ", channel))
      abline(v = event_lines_time, col = "red")
    }
  }
  if (type == "average") {
    if (!("GrandAverage" %in% names(x))) {
      stop("'GrandAverage' column is missing. Create this column using 'grand_average_ETG4000()'.")
    } else {
      plot(x$Time, x$GrandAverage, type = "l",
           xlab = "Time (s)", ylab = "Intensity",
           main = "Grand Average")
      abline(v = event_lines_time, col = "red")
    }
  }
}
