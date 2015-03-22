.onAttach <- function(lib, pkg) {
  register()
}

.onDetach <- function(lib, pkg) {
  deregister()
}
