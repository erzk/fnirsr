context("Loading correctly the ETG-4000 file")

test_that("external ETG-4000 file exists", {
  expect_true(
    file.exists(
      file.path(
        system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                    package = "fnirsr")))
      )
})

test_that("ETG-4000 file has the expected size", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  df <- load_ETG4000_data(file_path, header)

  expect_that(load_ETG4000_data(file_path), throws_error())
  expect_that(df, is_a("data.frame"))
  expect_equal(dim(df), c(3351, 30))
})
