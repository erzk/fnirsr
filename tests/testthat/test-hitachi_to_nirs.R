context("hitachi_to_nirs")

test_that("hitachi_to_nirs works", {
  file_path_nirs <- file.path(
    system.file("extdata", "Simple_Probe.nirs",
                package = "fnirsr"))

  expect_that(hitachi_to_nirs(file_path_nirs), throws_error())
})
