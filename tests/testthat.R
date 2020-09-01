library(testthat)
library(fars)

Sys.setenv("R_TESTS" = "")
test_check("fars")
