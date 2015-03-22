context("mappy")

describe("Setting shortcuts", {
  test_that("setting a shortcut is possible in the global environment", {
    mappy(hi = cat("Hello world"))
    expect_output(hi, "Hello world")
  })
})
