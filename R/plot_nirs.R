#' Plot the data extracted from a nirs file
#'
#' @param x A list.
#'
#' @return A plot.
#'
#' @examples
#' data <- load_nirs_data("Simple_Probe.nirs")
#' plot_nirs(data)
#' plot_nirs(data, type = "facets")
#'
#' @export
#'
plot_nirs <- function(x, type = "facets") {
  if (!is.list(x))
    stop("Please provide a list created from a nirs file.")
  x_zoo <- zoo(x$d)
  event_lines <- which(x$s != 0)

  if(type == "facets"){
    my.panel <- function(y, ...) {
      lines(y, ...)
      abline(v = event_lines, col = "red")
    }
    plot.zoo(x_zoo, ylim = c(min(x_zoo), max(x_zoo)),
             xlab = "Samples", main = "All channels", panel = my.panel)
  }
}
