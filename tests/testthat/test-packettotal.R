context("minimal package functionality")

skip_on_cran()

expect_true("user" %in% names(pt_usage()))

x <- pt_info("d210f4dbea97949f694e849507951881")
expect_true("md5" %in% names(x$pcap_metadata))

