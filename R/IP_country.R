#' Convert IP addresses to country names
#'
#' @param IPaddress A vector of IP addresses
#'
#' @return Returns a vector of country names for the locations of \code{IPaddress}
#'
#' @export
#'
#' @examples
#' IP_country(IP_generator(1000))
#'
#'
IP_country <- function(IPaddress) {
  # Convert IP address(es) to country(ies)
  #
  IPcode <- IP_code(IPaddress)
  Country <- IP_lookup(IPdatabase, IPcode)
  Country <- factor(Country)
  return(Country)
}


IP_code <- function(IPaddress) {
  # Convert IP address(es) to IP code(s)
  #
  IPa <- as.character(IPaddress)
  IPc <- strsplit(IPa, "\\.")
  IPc <- lapply(IPc, as.numeric)
  IPc <- do.call(rbind, IPc)
  IPc <- 16777216*IPc[, 1] + 65536*IPc[, 2] + 256*IPc[, 3] + IPc[, 4]
  return(IPc)
}


#' Title
#'
#' @param x IP database
#' @param y IP addresses
#'
#' @return Returns country from IP codes
#' @importFrom data.table setDT setkey data.table foverlaps
#' @export
#'
#' @examples
#' data1 <- IP_code(ips)
#' IP_lookup(data1)
IP_lookup <- function(x, y) {
  # Convert IP code(s) to country(ies)
  #
  DT <- setDT(x)
  setkey(DT, IPfrom, IPto)
  DT2 <- data.table(IPfrom = y, IPto = y)
  res <- foverlaps(DT2, DT[, .(IPfrom, IPto)], type="within")
  res[, i:=seq_len(nrow(res))]
  setkey(res, i)
  final <- merge(res, DT, by=c("IPfrom", "IPto"))[order(i), .(Country)]
  as.character(final[[1]])
}
