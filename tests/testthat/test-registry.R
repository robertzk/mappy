context("registry")

describe("Adding to the registry", {
  test_that("it can register an expression", {
            browser()
    mappy::register("a", quote(cat("Hello world")))
    with_mappy(expect_true(is.element("a", names(registry_map()))))
  })
})
