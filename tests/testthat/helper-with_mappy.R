library(testthatsomemore)

with_options <- function(options, expr) {
  old_options <- options(options)
  on.exit(options(old_options))
  eval.parent(substitute(expr))
}

with_mappy <- function(expr) {
  tempdir <- tempdir()
  with_options(list(mappy.file = file.path(tempdir, "mappy")), {
    memoise::forget(registry_dir)
    memoise::forget(registry_obj)
    on.exit(unlink(tempdir, TRUE, TRUE))
    eval.parent(substitute(expr))
  })
}

