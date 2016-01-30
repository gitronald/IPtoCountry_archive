# This line of code appeases the CRAN check for visible bindings, see:
# http://stackoverflow.com/questions/9439256/how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when?rq=1
utils::globalVariables(c("ip2location.lite.db1", "IPfrom", "IPto", "Country", ".", ":=", "i"))


#' Convert IP addresses to country names
#'
#' @param IP.address a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see ?IP.database
#' @return Returns a factor vector of country names corresponding to
#'   \code{IPaddress}
#'
#' @export
#' @examples
#' IP_country(IPs)
#'
#'
IP_country <- function(IP.address, IP.database = NULL) {
  # Convert IP address(es) to country(ies)
  #
  IP.code <- IP_code(IP.address)
  country <- IP_lookup(IP.code, IP.database)
  country <- factor(country)
  return(country)
}


#' Convert IP addresses to IP codes
#'
#' @param IP.address a character or factor vector of one or more IP addresses
#' @return Returns a numeric vector of IP codes corresponding to
#'   \code{IPaddress}
#'
#' @export
#' @examples
#' IP_code(IPs)
#'
IP_code <- function(IP.address) {
  # Convert IP address(es) to IP code(s)
  #
  IPa <- as.character(IP.address)
  IPc <- strsplit(IPa, "\\.")
  IPc <- lapply(IPc, as.numeric)
  IPc <- do.call(rbind, IPc)
  IPc <- 16777216*IPc[, 1] + 65536*IPc[, 2] + 256*IPc[, 3] + IPc[, 4]
  return(IPc)
}


#' Match IP codes in a IP database
#'
#' @param IP.code a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see ?IP.database
#' @return Returns country from IP codes
#' @importFrom data.table setDT setkey data.table foverlaps
#' @export
#' @examples
#' IPs.code <- IP_code(IPs)
#' IP_lookup(IPs.code)
IP_lookup <- function(IP.code, IP.database = NULL) {
  # Convert IP code(s) to country(ies)
  #
  if(is.null(IP.database)) IP.database <- ip2location.lite.db1
  DT <- setDT(IP.database)
  setkey(DT, IPfrom, IPto)
  DT2 <- data.table(IPfrom = IP.code, IPto = IP.code)
  res <- foverlaps(DT2, DT[, .(IPfrom, IPto)], type="within")
  res[, i:=seq_len(nrow(res))]
  setkey(res, i)
  final <- merge(res, DT, by=c("IPfrom", "IPto"))[order(i), .(Country)]
  final <- as.character(final[[1]])

  return(final)
}
