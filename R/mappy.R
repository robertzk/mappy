#' Assign an alias to an R expression in the interactive console.
#'
#' @param ... The named arguments will be translated to the aliases. See the
#'    accompanying examples.
#' @param envir environment. The environment to bind the aliases in using
#'    \code{\link{makeActiveBinding}}. By default, the global environment.
#' @param register logical. Whether or not to register the shortcut
#'    in the registry. By default, \code{TRUE} if \code{envir} is the global
#'    environment, and \code{FALSE} otherwise.
#' @return the names of the bound shortcuts.
#' @export
#' @examples
#' \dontrun{ 
#'   mappy(hi = cat("Hello world"))
#'   hi # Now, writing "hi" executes cat("Hello world")
#'   stopifnot(bindingIsActive("hi", globalenv()))
#'   unmappy("hi") # Now the shortcut is gone.
#' }
#'
#' env <- new.env()
#' mappy(m = lm(Sepal.Width ~ Sepal.Length, data = iris)$model, envir = env)
#' # Now, env$m will refer to the lm model object. Note that since the
#' # expression will be re-computed each time, so will the model!
#' model <- env$m
mappy <- function(..., envir = globalenv(), register = identical(envir, globalenv())) {
  stopifnot(is.environment(envir))
  stopifnot(is.logical(register) && length(register) == 1)

  if (!interactive()) return()

  expressions <- eval(substitute(alist(...)))
  check_expressions(expressions)

  lapply(seq_along(expressions), function(i) {
    make_binding(names(expressions)[i], expressions[[i]], envir, isTRUE(register))
  })
  names(expressions)
}

#' @rdname mappy 
#' @export
#' @inheritParams mappy
#' @param expression_names character. The expressions to unmap.
#' @param deregister logical. Whether or not to deregister the shortcut
#'    in the registry. By default, \code{TRUE} if \code{envir} is the global
#'    environment, and \code{FALSE} otherwise.
unmappy <- function(expression_names, envir = globalenv(),
                    deregister = identical(envir, globalenv())) {
  stopifnot(is.character(expression_names))
  if (!is_binding(expression_names, envir)) {
    warning(sQuote(expression_names), " is not a shortcut, skipping unmapping")
    return()
  }
  if (isTRUE(deregister)) deregister(expression_names)
  rm(list = expression_names, envir = envir)
}
unmappy <- Vectorize(unmappy, "expression_names")

#' A list of all mapped shortcuts.
#'
#' @include registry.R
#' @export
mappy_all <- function() {
  (registry_map()) # Explicit parens to prevent invisible
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

make_binding <- function(name, expr, envir, register) {
  fn   <- make_function(expr, envir)
  if (is_binding(name, envir)) {
    warning(sQuote(name), " is already a binding, overwriting.", call. = FALSE)
  }
  if (register) register(name, expr)
  makeActiveBinding(name, fn, env = envir)
}

is_binding <- function(name, envir) {
  exists(name, envir = envir, inherits = FALSE) && bindingIsActive(name, envir)
}
