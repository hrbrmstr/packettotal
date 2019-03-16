
[![Travis-CI Build
Status](https://travis-ci.org/hrbrmstr/packettotal.svg?branch=master)](https://travis-ci.org/hrbrmstr/packettotal)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/packettotal/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/packettotal)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/packettotal)](https://cran.r-project.org/package=packettotal)

# packettotal

Lookup and Analyze Packet Capture (‘PCAP’) Files

## Description

‘PacketTotal’ (<https://packettotal.com/>) is an engine for analyzing,
categorizing, and sharing packet capture (‘PCAP’) files. The tool was
built with the information security community in mind and has
applications in malware analysis and network forensics. Methods are
provided to query search for and analyze packet capture files.

## TODO

  - `/search/deep/` :
    <https://packettotal.com/api-docs/#/search/post_search_deep>
  - `/search/deep/results/{search_id}` :
    <https://packettotal.com/api-docs/#/search/get_search_deep_results__search_id_>

## What’s Inside The Tin

The following functions are implemented:

  - `packettotal_api_key`: Get or set PACKETTOTAL\_API\_KEY value
  - `pt_detail`: Get a detailed report of PCAP traffic, carved files,
    signatures, and top-talkers.
  - `pt_download`: Download a PCAP analysis archive. The result is a zip
    archive containing the PCAP itself, CSVs representing various
    analysis results, and all carved files.
  - `pt_info`: Get high-level information about a specific PCAP file.
  - `pt_random`: Get high-level information about a random PCAP file.
  - `pt_search`: Search with term or with a valid Lucene query.
  - `pt_similar`: Get a similarity graph relative to the current PCAP
    file.
  - `pt_usage`: Retrive usage and subscription plan information.

## Installation

``` r
devtools::install_git("https://gitlab.com/hrbrmstr/packettotal.git")
# or
devtools::install_github("hrbrmstr/packettotal")
```

## Usage

``` r
library(packettotal)

# current version
packageVersion("packettotal")
## [1] '0.1.0'
```

``` r
str(pt_random(), 2)
## List of 1
##  $ pcap_metadata:List of 11
##   ..$ md5               : chr "4be31ddcbfe4af10f0fbcb83681d1b67"
##   ..$ name              : chr "20130820_c_win6_00012_pc.pcap"
##   ..$ byte_size         : int 1552408
##   ..$ logs              : chr [1:8] "conn" "dns" "weird" "files" ...
##   ..$ analyzed_date     : chr "2018-10-19 00:50:01"
##   ..$ download_link     : chr "/pcaps/4be31ddcbfe4af10f0fbcb83681d1b67/download"
##   ..$ analysis_link     : chr "/pcaps/4be31ddcbfe4af10f0fbcb83681d1b67/analysis"
##   ..$ similar_pcaps_link: chr "/pcaps/4be31ddcbfe4af10f0fbcb83681d1b67/similar"
##   ..$ pcap_glyph_link   : chr "https://s3.amazonaws.com/packettotalpub/files/4be31ddcbfe4af10f0fbcb83681d1b67/pcap-mosaic.png"
##   ..$ packettotal_link  : chr "https://packettotal.com/app/analysis?id=4be31ddcbfe4af10f0fbcb83681d1b67"
##   ..$ message           : chr "This PCAP was selected randomly, since no id was specified."
```

``` r
str(pt_search("evil.com"), 2)
## List of 2
##  $ result_count: int 5
##  $ results     :'data.frame':    5 obs. of  3 variables:
##   ..$ id         : chr [1:5] "b2a094b1882f52ab8befd3d8ad9d7f9a" "0826bfbd4a68519945b9af594a5a87d7" "385b9a5b3da0d56260f2be329e110795" "8e13e95bc12ad8415c4d8e8d313affac" ...
##   ..$ found_in   :List of 5
##   ..$ match_score: num [1:5] 49.5 49.3 44.2 31.8 31.6
```

``` r
str(pt_info("d210f4dbea97949f694e849507951881"), 2)
## List of 1
##  $ pcap_metadata:List of 10
##   ..$ md5               : chr "d210f4dbea97949f694e849507951881"
##   ..$ name              : chr "20180815Emotetinfectipca.pcap"
##   ..$ byte_size         : int 1583713
##   ..$ logs              : chr [1:10] "conn" "x509" "dns" "ssl" ...
##   ..$ analyzed_date     : chr "2019-01-01 06:40:18"
##   ..$ download_link     : chr "/pcaps/d210f4dbea97949f694e849507951881/download"
##   ..$ analysis_link     : chr "/pcaps/d210f4dbea97949f694e849507951881/analysis"
##   ..$ similar_pcaps_link: chr "/pcaps/d210f4dbea97949f694e849507951881/similar"
##   ..$ pcap_glyph_link   : chr "https://s3.amazonaws.com/packettotalpub/files/d210f4dbea97949f694e849507951881/pcap-mosaic.png"
##   ..$ packettotal_link  : chr "https://packettotal.com/app/analysis?id=d210f4dbea97949f694e849507951881"
```

``` r
str(pt_detail("d210f4dbea97949f694e849507951881"), 2)
## List of 1
##  $ analysis_summary:List of 9
##   ..$ top_talkers          :List of 2
##   ..$ connection_statistics:List of 9
##   ..$ dns_statistics       :List of 2
##   ..$ file_statistics      :List of 3
##   ..$ signatures           : chr [1:4] "ET POLICY Office Document Download Containing AutoOpen Macro" "ET POLICY PE EXE or DLL Windows file download HTTP" "SURICATA TLS invalid record version" "SURICATA TLS invalid record/traffic"
##   ..$ external_references  :'data.frame':    7 obs. of  2 variables:
##   ..$ malicious_traffic    : logi FALSE
##   ..$ accuracy             : chr "perfect"
##   ..$ http_statistics      :List of 3
```

``` r
str(pt_similar("536cf06ca83704844d789f56caf22ee6"), 2)
## List of 4
##  $ similar                   :List of 2
##   ..$ result_count: int 78
##   ..$ results     :'data.frame': 78 obs. of  4 variables:
##  $ intensity                 : chr "minimal"
##  $ prioritize_uncommon_fields: logi TRUE
##  $ weighting_mode            : chr "behavior"
```

## packettotal Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R    |       12 | 0.92 | 152 | 0.93 |          52 | 0.68 |      111 | 0.67 |
| Rmd  |        1 | 0.08 |  12 | 0.07 |          25 | 0.32 |       55 | 0.33 |

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
