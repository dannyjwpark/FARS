test_that("Check number of rows for 2014 accidents file", {
  testthat::expect_equal(nrow(fars_read_years(2014)[[1]]), 30202)
})
