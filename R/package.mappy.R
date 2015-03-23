#' Register shortcuts in R
#'
#' This package provides the ability to create shortcuts for use in the
#' interactive R console to prevent yourself from writing commonly used
#' expressions multiple times.
#' 
#' For example, if you frequently find yourself typing
#'    \code{some_annoyingly$long_expression},
#' you can bind it to \code{S} by writing
#'    \code{mappy(S = some_annoyingly$long_expression)}.
#' Now, typing \code{S} in your interactive R console executes the expression
#' in full each time. Note that mappy relies on the ~/.R/mappy file to make
#' this work between sessions. If you wish to use a different file, set
#' \code{options(mappy.file = "/your/dir/file")}.
#'
#' Mappy shortcuts do not apply outside of interactive R sessions (see
#' \code{\link[base]{interactive}}.
#'
#' @name mappy
#' @importFrom memoise memoise
#' @importFrom director registry
#' @docType package
NULL
