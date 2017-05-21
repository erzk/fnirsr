context("Epoching the ETG-4000 file")

test_that("The epoching function works correctly", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  rawData <- load_ETG4000_data(file_path, header)
  df_epochs <- epoch_ETG4000(rawData, 1, 100, 100)

  expect_that(df_epochs, is_a("data.frame"))
  expect_equal(dim(df_epochs), c(1206, 30))
})
