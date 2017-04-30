context("Averaging the ETG-4000 file")

test_that("The averaging function works correctly", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  df <- load_ETG4000_data(file_path, header)
  df_ga <- grand_average_ETG4000(df)

  expect_that(df_ga, is_a("data.frame"))
  expect_that(names(df_ga[31]), equals("GrandAverage"))
  expect_is(df_ga[,31], "numeric")
  expect_equal(dim(df_ga), c(3351, 31))
  expect_equal(mean(df_ga[,31]), -0.04466002)
})
