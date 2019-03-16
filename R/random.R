#' Get high-level information about a random PCAP file.
#'
#' Randomly selected PCAPs come from a set of pre-selected, interesting PCAP files.
#'
#' @param api_key your [packettotal_api_key()].
#' @references <https://packettotal.com/api-docs/#/pcaps/get_pcaps>
#' @export
#' @examples
#' str(try(pt_random(), silent=TRUE), 1)
pt_random <- function(api_key = packettotal_api_key()) {

  httr::GET(
    url = "https://api.packettotal.com/v1/pcaps",
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