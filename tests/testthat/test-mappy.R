context("mappy")

describe("Setting shortcuts", {
  test_that("it does not accept one unnamed expression", {
    expect_error(mappy(test), "must be named")
  })

  test_that("it does not accept one named and one unnamed expression", {
    expect_error(mappy(test, b = test), "must be named")
  })

  test_that("it does not allow duplication in expression names", {
    expect_error(mappy(b = test, b = test), "must be unique")
  })

  test_that("setting a shortcut is possible in the global environment", {
    mappy(hi = cat("Hello world"))
    expect_output(hi, "Hello world")
    rm("hi", envir = globalenv()) # Clean up
  })

  test_that("setting a shortcut is possible in a custom environment", {
    env <- new.env()
    mappy(hi = cat("Hello world"), envir = env)
    expect_output(env$hi, "Hello world")
  })
})

describe("Unmapping shortcuts", {
  test_that("it 
})

