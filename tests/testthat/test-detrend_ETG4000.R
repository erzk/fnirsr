context("Detrending the ETG-4000 data")

test_that("Detrending works correctly", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  df <- load_ETG4000_data(file_path, header)
  fnirs_detrended <- detrend_ETG4000_data(df)

  expect_that(detrend_ETG4000_data(), throws_error())
  expect_that(detrend_ETG4000_data(df, "single"), throws_error())
  expect_that(detrend_ETG4000_data(df, "some", 24), throws_error())
  expect_that(fnirs_detrended, is_a("data.frame"))
  expect_equal(dim(fnirs_detrended), dim(df))
})
