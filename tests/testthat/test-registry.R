context("registry")
library(testthatsomemore)

describe("Adding to the registry", {
  test_that("it can register an expression", {
    with_mappy({
      mappy::register("a", quote(cat("Hello world")))
      expect_true(is.element("a", names(registry_map())))
    })
  })
})
