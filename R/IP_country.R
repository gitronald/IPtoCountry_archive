# This line of code appeases the CRAN check for visible bindings, see:
# http://stackoverflow.com/questions/9439256/how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when?rq=1
utils::globalVariables(c("ip2location.lite.db1", "IPfrom", "IPto", "Country", ".", ":=", "i"))


#' Convert IP address to country name
#'
#' @param IP.address a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see \code{?ip2location.lite.db1}
#' @return Returns a factor vector of country names corresponding to
#'   \code{IP.address}
#'
#' @export
#' @examples
#' IP_country(IPs)
#'
IP_country <- function(IP.address, IP.database = NULL) {
  IP.integer <- IP_integer(IP.address)
  country <- IP_lookup(IP.integer, IP.database)
  country <- factor(country)
  return(country)
}


#' Convert IP address to IP integer
#'
#' @param IP.address a character or factor vector of one or more IP addresses
#' @return Returns a numeric vector of IP integers from \code{IP.address}. The
#'   coversion formula used here splits the string into four octets, multiplies
#'   the first three by 256^(4-n), and takes the sum of the four modified
#'   octets.
#' @export
#' @examples
#' IP_integer(IPs)
#'
IP_integer <- function(IP.address) {
  IPa <- as.character(IP.address)
  IPc <- strsplit(IPa, "\\.")
  IPc <- lapply(IPc, as.numeric)
  IPc <- do.call(rbind, IPc)
  IPc <- 16777216*IPc[, 1] + 65536*IPc[, 2] + 256*IPc[, 3] + IPc[, 4]
  return(IPc)
}


#' Match IP integer to country name
#'
#' @param IP.integer a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see \code{?ip2location} for details on
#'   default database from \url{http://lite.ip2location.com}
#' @return Returns country from IP integers
#' @importFrom data.table setDT setkey data.table foverlaps
#' @export
#' @examples
#' IP.integer <- IP_integer(IPs)
#' IP_lookup(IP.integer)
IP_lookup <- function(IP.integer, IP.database = NULL) {
  if(is.null(IP.database)) IP.database <- ip2location.lite.db1
  DT <- setDT(IP.database)
  setkey(DT, IPfrom, IPto)
  DT2 <- data.table(IPfrom = IP.integer, IPto = IP.integer)
  res <- foverlaps(DT2, DT[, .(IPfrom, IPto)], type="within")
  res[, i:=seq_len(nrow(res))]
  setkey(res, i)
  final <- merge(res, DT, by=c("IPfrom", "IPto"))[order(i), .(Country)]
  final <- as.character(final[[1]])
  return(final)
}
