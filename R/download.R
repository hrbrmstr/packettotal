#' Download a PCAP analysis archive. The result is a zip archive containing the PCAP itself, CSVs representing various analysis results, and all carved files.'
#'
#' @param pcap_id An md5 hash corresponding to the PCAP file submission on PacketTotal.com.
#'        This hash can be derived by hashing the PCAP file in question.
#' @param dl_dir directory where to store the download
#' @param archive_name name of the ZIP file. If left `NULL` then a ZIP file
#'        will be created with the name `YYYY-mm-dd-pcap_id.zip`.
#' @param api_key your [packettotal_api_key()].
#' @return if successful and the analysis package is ready then the full path
#'         to the ZIP file is returned (invisibly). If the analysis package
#'         is not ready the return value is "`_PROCESSING_`".
#' @references <https://packettotal.com/api-docs/#/pcaps/get_pcaps__pcap_id__download>
#' @export
#' @examples
#' str(try(pt_download("536cf06ca83704844d789f56caf22ee6"), silent=TRUE), 2)
pt_download <- function(pcap_id, dl_dir = getwd(), archive_name = NULL,
                        api_key = packettotal_api_key()) {

  dl_dir <- path.expand(dl_dir)
  stopifnot(dir.exists(dl_dir))

  httr::GET(
    url = sprintf("https://api.packettotal.com/v1/pcaps/%s/download", pcap_id),
    httr::add_headers(
      `x-api-key` = api_key
    ),
    .PACKETTOTAL_UA
  ) -> res

  httr::stop_for_status(res)

  status_code <- httr::status_code(res)

  if (status_code == "200") {
    out <- httr::content(res, as = "raw", encoding = "UTF-8")
    if (is.null(archive_name)) {
      loc <- file.path(dl_dir, sprintf("%s-%s.zip", as.character(Sys.Date()), pcap_id))
    } else {
      loc <- file.path(dl_dir, archive_name)
    }
    writeBin(
      object = out,
      con = loc,
      useBytes = TRUE
    )
    message("Download is at ", loc)
    return(invisible(loc))
  } else {
    message(
      "PCAP exists but the analysis package is not ready. ",
      "Try calling the function again in a few minutes."
    )
  }

}