#' Search with term or with a valid Lucene query.
#'
#' Receive a set of matches for given query.
#'
#' @param query search term (e.g. an IP address, domain, or file hash) or valid Lucene query
#' @param api_key your [packettotal_api_key()].
#' @export
#' @references <https://packettotal.com/api-docs/#/search
#' @examples
#' str(try(pt_search("evil.com"), silent=TRUE), 1)
pt_search <- function(query, api_key = packettotal_api_key()) {

  httr::GET(
    url = "https://api.packettotal.com/v1/search",
    query = list(
      query = query
    ),
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

