context("Loading correctly the ETG-4000 file")

test_that("external ETG-4000 file exists", {
  expect_true(
    file.exists(
      file.path(
        system.file("extdata", "Hitachi_ETG4000_24Ch_Total.csv",
                    package = "fnirsr")))
      )
})

