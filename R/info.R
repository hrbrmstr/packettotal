#' Get high-level information about a specific PCAP file.
#'
#' Results will contain high-level information, such as what logs were extracted, the date it was analyzed, and additional references.
#'
#' @param pcap_id An md5 hash corresponding to the PCAP file submission on PacketTotal.com.
#'        This hash can be derived by hashing the PCAP file in question.
#' @param api_key your [packettotal_api_key()].
#' @references <https://packettotal.com/api-docs/#/pcaps/get_pcaps>
#' @export
#' @examples
#' str(try(pt_info("d210f4dbea97949f694e849507951881"), silent=TRUE), 2)
pt_info <- function(pcap_id, api_key = packettotal_api_key()) {

  httr::GET(
    url = sprintf("https://api.packettotal.com/v1/pcaps/%s", pcap_id),
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