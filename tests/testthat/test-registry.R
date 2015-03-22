context("registry")
library(testthatsomemore)

describe("Adding to the registry", {
  test_that("it errors when a non-character is passed", {
    expect_error(register(5, quote(cat("hi"))))
  })

  test_that("it does nothing when no expressions are passed", {
    with_mappy({
      register(character(0), quote(cat("hi")))
      expect_null(registry_map())
    })
  })

  test_that("it errors when a non-language object is passed for the expression", {
    expect_error(register("foo", 5))
  })

  test_that("it can register an expression", {
    with_mappy({
      register("a", quote(cat("Hello world")))
      expect_true(is.element("a", names(registry_map())))
    })
  })
})
