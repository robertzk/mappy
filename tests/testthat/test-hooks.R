context("package hooks")
library(testthatsomemore)

test_that("it can load shortcuts into the global environment when attached", {
  with_mappy({
    env <- new.env()
    mappy(hi = assign("x", 1, envir = globalenv()))
    testthatsomemore::package_stub("base", "interactive", function() TRUE, {
    testthatsomemore::package_stub("base", "globalenv", function() env, {
      mappy:::.onAttach(character(0), "mappy")
      env$hi
      expect_equal(env$x, 1)
    }) })
  })
})

test_that("it can unload shortcuts frmo the global environment when detached", {
  with_mappy({
    env <- new.env()
    mappy(hi = assign("x", 1, envir = globalenv()))
    testthatsomemore::package_stub("base", "interactive", function() TRUE, {
    testthatsomemore::package_stub("base", "globalenv", function() env, {
      mappy:::.onAttach(character(0), "mappy")
      mappy:::.onDetach(character(0))
      env$hi
      expect_null(env$x)
    }) })
  })
})
