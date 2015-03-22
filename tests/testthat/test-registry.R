context("registry")
library(testthatsomemore)

describe("Adding to the registry", {
  test_that("it errors when a non-character is passed", {
    expect_error(register(5, quote(cat("hi"))))
  })

  test_that("it does nothing when no expressions are passed", {
    with_mappy({
      register(character(0), quote(cat("hi")))
      expect_equal(length(registry_map()), 0)
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

  test_that("it can register multiple expressions", {
    with_mappy({
      register(c("a", "b"), list(quote(cat("Hello world")), quote(cat("Hi"))))
      expect_true(is.element("a", names(registry_map())))
      expect_true(is.element("b", names(registry_map())))
    })
  })
})

describe("Removing from the registry", {
  test_that("it errors when a non-character is passed", {
    expect_error(deregister(5))
  })

  test_that("it can remove from the registry", {
    with_mappy({
      register("a", quote(cat("Hello world")))
      deregister("a")
      expect_false(is.element("a", names(registry_map())))
    })
  })

  test_that("it can remove multiple objects from the registry", {
    with_mappy({
      register("a", quote(cat("Hello world")))
      register("b", quote(cat("Hello world")))
      deregister(c("a", "b"))
      expect_false(is.element("a", names(registry_map())))
      expect_false(is.element("b", names(registry_map())))
    })
  })
})

describe("Loading a registry", {
  test_that("it can load the registry into an environment", {
    with_mappy({
      env <- new.env()
      register("a", quote(env$y <- "Hello world"))
      load_registry(env)
      env$a
      expect_equal(env$y, "Hello world")
    })
  })
})

describe("Unloading a registry", {
  test_that("it can unload the registry from an environment", {
    with_mappy({
      env <- new.env()
      register("a", quote(cat("Hello world")))
      load_registry(env)
      unload_registry(env)
      expect_null(env$a)
    })
  })
})

memoise::forget(mappy_file)
memoise::forget(registry_dir)
memoise::forget(registry_obj)
