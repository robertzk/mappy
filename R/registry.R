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
  stopifnot(is.character(name))
  if (length(name) == 0) return()
  else if (length(name) > 1) {
    stopifnot(length(expr) == length(name))
    for (i in seq_along(name)) { Recall(name[[i]], expr[[i]]) }
    return()
  }
  stopifnot(is.language(expr))

  maps         <- registry_map()
  maps[[name]] <- expr
  registry_obj()$set(mappy_file(), maps)
}

#' @rdname register
deregister <- function(name) {
  stopifnot(is.character(name) && length(name) == 1)

  maps         <- registry_map()
  maps[[name]] <- NULL
  registry_obj()$set(mappy_file(), maps)
  name
}
deregister <- Vectorize(deregister)

#' Load the registry of stored shortcuts into an environment.
#'
#' @param envir environment. By default, the global environment.
load_registry <- function(envir) {
  exprs          <- registry_map()
  exprs$envir    <- envir
  exprs$register <- FALSE
  do.call(mappy, exprs)
}

#' @rdname load_registry
unload_registry <- function(envir) {
  suppressWarnings(rm(list = names(registry_map()), envir = envir))
}

#' @importFrom director registry
registry_obj <- memoise::memoise(function() {
  director::registry$new(registry_dir())
})

registry_map <- function() {
  registry_obj()$get(mappy_file())
}

mappy_file <- memoise::memoise(function() {
  basename(getOption("mappy.file") %||% "mappy")
})

registry_dir <- memoise::memoise(function() {
  dirname(getOption("mappy.file") %||% "~/.R/foo")
})


