.onAttach <- function(lib, pkg) {
  if (interactive()) {
    packageStartupMessage("Attaching mappy shortcuts...\n")
    load_registry(globalenv())
  }
}

.onDetach <- function(lib) {
  if (interactive()) {
    packageStartupMessage("Detaching mappy shortcuts...\n")
    unload_registry(globalenv())
  }
}
