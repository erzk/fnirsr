context("Loading correctly the ETG-4000 header")

test_that("ETG-4000 file has the expected size", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)

  expect_that(header, is_a("list"))
  expect_length(header, 31)
})
