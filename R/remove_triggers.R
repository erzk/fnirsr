#' Remove triggers from the ETG-4000 data
#'
#' Removes triggers/markings from ETG-4000 files. Triggers are replaced with 0.
#' This functions can replace all triggers or every other trigger. The latter
#' prepares data frames to be loaded into Homer2.
#'
#' @importFrom dplyr group_by
#' @importFrom dplyr mutate
#' @importFrom dplyr row_number
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#'
#' @param x A data frame with an ETG-4000 data.
#' @param trigger An integer representign a trigger/marking to remove.
#' @param n A character describing which trigger to remove.
#' Allowed options: 'every' (default - removed all triggers) and 'every_other'
#' (removes every other trigger - to prepare ETG-4000 data for loading into Homer2).
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' file_path <- system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv", package = "fnirsr")
#' ETG_header <- load_ETG4000_header(file_path)
#' ETG_data <-load_ETG4000_data(file_path, ETG_header)
#' remove_triggers(ETG_data, 1)
#' remove_triggers(ETG_data, 1, "every_other")
#'
remove_triggers <- function(x, trigger = NULL, n = "every") {
  if (!is.data.frame(x))
    stop("Please provide a data frame with ETG-4000 data.")
  if (missing(trigger))
    stop("Please provide a trigger/mark) to be removed.")
  if (!("Mark" %in% names(x)))
    stop("There is no Mark column in the provided data frame.")
  if (length(which(x$Mark == trigger)) == 0)
    stop("Provided trigger is not in the data set.")
  if (!(n %in% c("every", "every_other")))
    stop("Specify the trigger to remove: 'every' or 'every_other'.")
  if (n == "every_other")  {
    x <- x %>% group_by(Mark) %>% mutate(Count = row_number()) %>% data.frame()
    double_marks <- which(x$Mark == trigger & x$Count %% 2 == 0)
    x$Mark[double_marks] <- 0
    x <- subset(x, select = -Count)
    return(x)
  } else {
  trigger_pos <- which(x$Mark == trigger)
  x[trigger_pos,] <- 0
  return(x)
  }
}
