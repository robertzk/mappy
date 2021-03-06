% Generated by roxygen2 (4.1.0.9001): do not edit by hand
% Please edit documentation in R/registry.R
\name{register}
\alias{deregister}
\alias{register}
\title{Store mappy shortcut in the registry.}
\usage{
register(name, expr)

deregister(name)
}
\arguments{
\item{name}{character. The name of the shortcut to store.}

\item{expr}{expression. The R expression to attach to this shortcut.}
}
\description{
The registry is a file that the mappy package maintains so that shortcuts
can persist across sessions. By default, it resides in \code{~/.R/mappy},
but you can change this by setting \code{options(mappy.file = "/your/file")}.
}
\details{
\itemize{
  \item{\code{register}}{stores the named expression in the registry so it will be
    restored when the mappy package is re-attached in a new session.}
  \item{\code{deregister}}{removes the named expression from the registry}
}
}
\note{
the registry will be auto-loaded into the global environment when
   the mappy package is attached.
}

