#' Get or set PACKETTOTAL_API_KEY value
#'
#' The API wrapper functions in this package all rely on a PacketTotal API
#' key residing in the environment variable `PACKETTOTAL_API_KEY`.
#' The easiest way to accomplish this is to set it
#' in the `.Renviron` file in your home directory.
#'
#' @md
#' @param force Force setting a new PacketTotal key for the current environment?
#' @return atomic character vector containing the PacketTotal api key
#' @references <https://packettotal.com/api-docs/>
#' @export
packettotal_api_key <- function(force = FALSE) {

  env <- Sys.getenv('PACKETTOTAL_API_KEY')
  if (!identical(env, "") && !force) return(env)

  if (!interactive()) {
    stop("Please set env var PACKETTOTAL_API_KEY to your PacketTotal key",
         call. = FALSE)
  }

  message("Couldn't find env var PACKETTOTAL_API_KEY See ?packettotal_api_key for more details.")
  message("Please enter your API key:")
  pat <- readline(": ")

  if (identical(pat, "")) {
    stop("PacketTotal key entry failed", call. = FALSE)
  }

  message("Updating PACKETTOTAL_API_KEY env var")
  Sys.setenv(PACKETTOTAL_API_KEY = pat)

  pat

}
