context("plot_ETG4000")

test_that("plot_ETG4000 works", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  df <- load_ETG4000_data(file_path, header)

  expect_that(plot_ETG4000(df, "all"), throws_error())
})
