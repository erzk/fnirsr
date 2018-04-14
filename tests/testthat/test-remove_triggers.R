context("Removing triggers from the ETG-4000 file")

test_that("Removing triggers works correctly", {
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  header <- load_ETG4000_header(file_path)
  df <- load_ETG4000_data(file_path, header)
  df_trim <- df[, 1:3]
  df_rm1 <- remove_triggers(df, 1)
  df_rm2 <- remove_triggers(df, 1, "every_other")

  expect_that(remove_triggers(header,1), throws_error())
  expect_that(remove_triggers(df), throws_error())
  expect_that(remove_triggers(df, 2), throws_error())
  expect_that(remove_triggers(df_trim, 1), throws_error())
  expect_that(remove_triggers(df_trim, 1, "test"), throws_error())

  expect_that(df_rm1, is_a("data.frame"))
  expect_that(df_rm2, is_a("data.frame"))
  expect_equal(unique(df_rm1$Mark), 0)
  expect_equal(unique(df_rm2$Mark), c(0, 1))
})
