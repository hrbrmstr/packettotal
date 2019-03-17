#' Retrive usage and subscription plan information.
#'
#' Handy helper to determine how many requests you have remaining.
#'
#' @param api_key your [packettotal_api_key()].
#' @export
#' @examples
#' str(try(pt_usage(), silent=TRUE), 2)
pt_usage <- function(api_key = packettotal_api_key()) {

  httr::GET(
    url = "https://api.packettotal.com/v1/usage",
    httr::add_headers(
      `x-api-key` = api_key
    ),
    .PACKETTOTAL_UA
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  out

}