context("Removing channels from the ETG-4000 file")

test_that("Removing channels works correctly", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  df <- load_ETG4000_data(file_path, header)
  df_rm1 <- remove_channels_ETG4000(df, 14)
  df_rm2 <- remove_channels_ETG4000(df, channel = c(15, 20))

  expect_that(remove_channels_ETG4000(df), throws_error())
  expect_that(df_rm1, is_a("data.frame"))
  expect_that(df_rm2, is_a("data.frame"))
  expect_equal(dim(df_rm1), c(3351, 29))
  expect_equal(dim(df_rm2), c(3351, 28))
})
