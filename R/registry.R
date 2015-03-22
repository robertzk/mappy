#' Store mappy shortcut in the registry.
#'
#' The registry is a file that the mappy package maintains so that shortcuts
#' can persist across sessions. By default, it resides in \code{~/.R/mappy},
#' but you can change this by setting \code{options(mappy.file = "/your/file")}.
#'
#' \itemize{
#'   \item{\code{register}}{stores the named expression in the registry so it will be
#'     restored when the mappy package is re-attached in a new session.}
#'   \item{\code{deregister}}{removes the named expression from the registry}
#' }
#' 
#' @param name character. The name of the shortcut to store.
#' @param expr expression. The R expression to attach to this shortcut.
#' @note the registry will be auto-loaded into the global environment when
#'    the mappy package is attached.
#' @importFrom director registry
register <- function(name, expr) {
  stopifnot(is.character(name) && length(name) == 1)
  stopifnot(is.expression(expr))

  maps <- registry()$get(mappy_file())
  maps$name <- expr
  registry()$set(mappy_file(), maps)
}
register <- Vectorize(register)

#' @rdname register
deregister <- function(name) {
  stopifnot(is.character(name) && length(name) == 1)

  maps <- registry()$get(mappy_file())
  maps[[name]] <- NULL
  registry()$set(mappy_file(), maps)
}
deregister <- Vectorize(deregister)

#' Load the registry of stored shortcuts into an environment.
#'
#' @param envir environment. By default, the global environment.
load_registry <- function(envir) {
  exprs       <- registry()$get(mappy_file())
  exprs$envir <- envir
  do.call(mappy, exprs)
}

#' @importFrom director registry
registry <- memoise::memoise(function() {
  director::registry$new(registry_dir())
})

mappy_file <- memoise::memoise(function() {
  basename(getOption("mappy.file")) %||% "mappy"
})

registry_dir <- memoise::memoise(function() {
  dirname(getOption("mappy.file")) %||% "~/.R"
})


