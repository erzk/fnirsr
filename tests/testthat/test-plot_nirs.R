context("plot_nirs")

test_that("plot_nirs works", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  df <- load_ETG4000_data(file_path, header)

  expect_that(plot_nirs(df), throws_error())
})
