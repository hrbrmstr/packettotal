#' Create a new deep search task. Search for a term or with a Lucene query.
#'
#' Unlike the more lighweight [pt_search()] results from this endpoint
#' will be available at the returned URL.
#'
#' @param query search term (e.g. an IP address, domain, or file hash) or valid Lucene query
#' @param api_key your [packettotal_api_key()].
#' @export
#' @references <https://packettotal.com/api-docs/#/search
#' @examples
#' str(try(pt_deep_search("botnet OR malware"), silent=TRUE), 1)
pt_deep_search <- function(query, api_key = packettotal_api_key()) {

  httr::POST(
    url = "https://api.packettotal.com/v1/search/deep",
    body = list(
      query = query
    ),
    encode = "json",
    httr::add_headers(
      `x-api-key` = api_key
    ),
    .PACKETTOTAL_UA
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  class(out) <- "pt_search_result"

  out

}

#' @rdname pt_deep_search
#' @param search_result output from [pt_deep_search()] or a plain search results id
#' @export
pt_get_search_results <- function(search_result, api_key = packettotal_api_key()) {

  res_url <- NULL
  if (inherits(search_result, "pt_search_result")) {
    res_url <- sprintf("https://api.packettotal.com%s", search_result$results_uri)
  } else if (is.character(search_result)) {
    search_result <- search_result[1]
    if (grepl("v1/", search_result)) {
      res_url <- sprintf("https://api.packettotal.com%s", search_result)
    } else {
      res_url <- sprintf("https://api.packettotal.com/v1/search/deep/results/%s", search_result)
    }
  }

  if (is.null(res_url)) stop("Unrecognized search result.", call.=FALSE)

  httr::GET(
    url = res_url,
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