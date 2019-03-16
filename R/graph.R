#' Get a similarity graph relative to the current PCAP file.
#'
#' Results contain PCAPs that exhibit similar behaviors or contain similar content. Results are organized with the most similar PCAPs on top, and the terms that were found shared within both.
#'
#' @param pcap_id An md5 hash corresponding to the PCAP file submission on PacketTotal.com.
#'        This hash can be derived by hashing the PCAP file in question.
#' @param weighting_mode One of "`behavior`" (default) or "`content`". Weight search results either based on their similarity to the behaviors exhibited or contents contained within the current PCAP file.
#' @param intensity One of "`minimal`" (default), "`low`", "`medium`", or "`high`". The scope of the search, basically translates to the maximum number of aggregations to exhaust. Using a high level intensity, may result in occassional timeouts.
#' @param prioritize_uncommon_fields By default, the most common values are used to seed the initial similarity search. Enabling this parameter, seeds the initial search with the least common values instead.
#' @param api_key your [packettotal_api_key()].
#' @references <https://packettotal.com/api-docs/#/pcaps/get_pcaps__pcap_id__similar>
#' @export
#' @examples
#' str(try(pt_similar("536cf06ca83704844d789f56caf22ee6"), silent=TRUE), 3)
pt_similar <- function(pcap_id,
                       weighting_mode = c("behavior", "content"),
                       intensity = c("minimal", "low", "medium", "high"),
                       prioritize_uncommon_fields = FALSE,
                       api_key = packettotal_api_key()) {

  weighting_mode <- match.arg(tolower(weighting_mode), c("behavior", "content"))
  intensity <- match.arg(tolower(intensity), c("minimal", "low", "medium", "high"))
  prioritize_uncommon_fields <- tolower(as.character(FALSE))

  httr::GET(
    url = sprintf("https://api.packettotal.com/v1/pcaps/%s/similar", pcap_id),
    query = list(
      weighting_mode = weighting_mode,
      intensity = intensity,
      prioritize_uncommon_fields = prioritize_uncommon_fields
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