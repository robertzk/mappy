with_options <- function(options, expr) {
  old_options <- options(options)
  on.exit(options(old_options))
  eval.parent(substitute(expr))
}

with_mappy <- function(expr) {
  within_file_structure(list(mappy = ""), {
    with_options(list(mappy.file = file.path(tempdir, "mappy")), {
      eval.parent(substitute(expr))
    })
  })
}
