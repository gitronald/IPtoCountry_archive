#' IP addresses
#'
#' A dataset containing 1000 randomly generated IP addresses
#'
#' @format A character vector with length 1000
#' @source Generated using \code{\link{IP_generator}}
"IPs"


#' IP database
#'
#' A dataset containing 141,822 IP code ranges and their corresponding country
#' names and abbreviations
#'
#' @format A data.frame with four variables
#' \describe{
#'   \item{IPFrom}{Start of IP code range}
#'   \item{IPto}{End of IP code range}
#'   \item{Abrv}{Two-character country code based on ISO 3166.}
#'   \item{Country}{Country name based on ISO 3166.}
#' }
#' @source \url{http://lite.ip2location.com}
"ip2location.lite.db1"
