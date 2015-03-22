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
mappy <- function(..., envir) {

}

