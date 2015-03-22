#' Assign an alias to an R expression in the interactive console.
#'
#' @param ... The named arguments will be translated to the aliases. See the
#'    accompanying examples.
#' @param envir environment. The environment to bind the aliases in using
#'    \code{\link{makeActiveBinding}}. By default, the global environment.
#' @examples
#' mappy(hi = cat("Hello world"))
#' hi # Now, writing "hi" executes cat("Hello world")
#'
#' env <- new.env()
#' mappy(m = lm(Sepal.Width ~ Sepal.Length, data = iris)$model, envir = env)
#' # Now, env$m will refer to the lm model object. Note that since the
#' # expression will be re-computed each time, so will the model!
mappy <- function(..., envir = globalenv()) {
  stopifnot(is.environment(envir))

  expressions <- eval(substitute(alist(...)))
  check_expressions(expressions)

  lapply(seq_along(expressions), function(i) {
    fn <- make_function(expressions[[i]], envir)
    makeActiveBinding(names(expressions)[i], fn, env = envir)
  })
}

check_expressions <- function(expressions) {
  expression_names <- names(expressions)

  if ((length(expressions) > 0 && is.null(expression_names)) ||
      (any(!nzchar(expression_names)))) {
    stop("All expressions must be named.")
  }

  if (anyDuplicated(expression_names)) {
    stop("All expression names must be unique, but ",
         paste(unique(expression_names[duplicated(expression_names)]), collapse = ", "),
        "occur multiple times.") 
  }

  expression_names
}

make_function <- function(expr, envir) {
  fn <- eval(call("function", as.pairlist(list()), expr))
  environment(fn) <- envir
  fn
}
