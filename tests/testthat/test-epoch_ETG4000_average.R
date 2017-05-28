context("Averaging the epoched ETG-4000 data")

test_that("The averaging function works correctly", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  rawData <- load_ETG4000_data(file_path, header)
  df_epochs <- epoch_ETG4000(rawData, 1, -100, 100)
  df_epochs_average <- epoch_ETG4000_average(df_epochs, -100, 100)
  df_epochs_average_pos <- epoch_ETG4000_average(df_epochs, 100, 100)

  expect_that(df_epochs_average, is_a("data.frame"))
  expect_equal(dim(df_epochs_average), c(201, 25))
  expect_equal(df_epochs_average, df_epochs_average_pos)
})
