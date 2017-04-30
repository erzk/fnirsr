#' Plot the data extracted from a nirs file
#'
#' @import zoo
#'
#' @param x A list.
#' @param type A string. Defaults to "facets".
#'
#' @return A plot.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Simple_Probe.nirs", package = "fnirsr")
#' data <- load_nirs_data(file_path)
#'
#' plot_nirs(data)
#' plot_nirs(data, type = "facets")
#'
plot_nirs <- function(x, type = "facets") {
  if (!is.list(x) || is.data.frame(x))
    stop("Please provide a list created from a nirs file.")
  x_zoo <- zoo(x$d)
  event_lines <- which(x$s != 0)

  if (type == "facets") {
    my.panel <- function(y, ...) {
      lines(y, ...)
      abline(v = event_lines, col = "red")
    }
    plot.zoo(x_zoo, ylim = c(min(x_zoo), max(x_zoo)),
             xlab = "Samples", main = "All channels", panel = my.panel)
  }
}
