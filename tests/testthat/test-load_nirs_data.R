context("Loading correctly the nirs file")

test_that("external nirs file exists", {
  expect_true(
    file.exists(
      file.path(
        system.file("extdata", "Simple_Probe.nirs",
                    package = "fnirsr")))
  )
})

test_that("nirs file has the expected size", {
  file_path_nirs <- file.path(
    system.file("extdata", "Simple_Probe.nirs",
                package = "fnirsr"))
  file_path <- file.path(
    system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                package = "fnirsr"))
  nirs_df <- load_nirs_data(file_path_nirs)

  expect_that(load_nirs_data(file_path), throws_error())
  expect_that(nirs_df, is_a("list"))
  expect_length(nirs_df, 6)
})
