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
#' head(IP_integer(IPs))
#'
IP_integer <- function(IP.address) {

  ip.split <- IP_split(IP.address)
  ip.integer = unname(16777216*ip.split[, 1] + 65536*ip.split[, 2] + 256*ip.split[, 3] + ip.split[, 4])
  return(ip.integer)
}


#' Split IP addresses
#'
#' @param IP.address vector of IPv4 addresses
#' @param integer logical, convert output to class integer
#' @param data.frame logical, convert output to data.frame
#'
#' @return Returns a matrix or data.frame with four columns and as many rows as
#'   IP.addresses were inputted
#' @export
#'
#' @examples
#' head(IP_split(IPs))
IP_split <- function(IP.address, integer = TRUE, data.frame = TRUE) {
  ip.split <- strsplit(IP.address, "\\.")
  ip.split <- do.call(rbind, ip.split)
  if(integer) ip.split <- apply(ip.split, 2, as.integer)
  if(data.frame) ip.split <- as.data.frame(ip.split)
  if(length(IP.address) == 1) ip.split = t(ip.split)
  return(ip.split)
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
IP_lookup2 <- function(IP.integer, IP.database = NULL) {
  if(is.null(IP.database)) IP.database <- ip2location.lite.db11
  DT <- setDT(IP.database)
  setkey(DT, IPfrom, IPto)
  DT2 <- data.table(IPfrom = IP.integer, IPto = IP.integer)
  res <- foverlaps(DT2, DT[, .(IPfrom, IPto)], type="within")
  res[, i:=seq_len(nrow(res))]
  setkey(res, i)
  final <- merge(res, DT, by=c("IPfrom", "IPto"))[order(i), .(Country, Region, City, Zip)]

  country <- as.vector(as.character(final[[1]]))
  region <- as.vector(as.character(final[[2]]))
  city <- as.vector(as.character(final[[3]]))
  zip <- as.vector(as.character(final[[4]]))

  final <- data.frame(country, region, city, zip)
#   final <- data.frame(as.character(final[[1]]), as.character(final[[2]]),
#                       as.character(final[[3]]), as.character(final[[4]]),
#                       col.names = c("Country", "Region", "City", "Zip"))
  return(final)
}


#' Convert IP address to country name, region, city, and zip code
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
IP_country2 <- function(IP.address, IP.database = NULL) {
  IP.integer <- IP_integer(IP.address)
  country <- IP_lookup2(IP.integer, IP.database)
  return(country)
}


#' Convert IP address to country name, region, city, and zip code
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
IP_country4 <- function(IP.address, IP.database = NULL, country.input = T,
                        region = F, city = F, zip = F) {
  IP.integer <- IP_integer(IP.address)
  country <- IP_lookup2(IP.integer, IP.database)

  add <- vector()
  index <- 1

  if(country.input) {
    add[index] <- 1
    index <- index + 1
  }
  if(region) {
    add[index] <- 2
    index <- index + 1
  }
  if(city) {
    add[index] <- 3
    index <- index + 1
  }
  if(zip) {
    add[index] <- 4
    index <- index + 1
  }

  sample <- list()
  for(i in 1:length(add)) {
    sample <- append(sample, country[[add[i]]])
  }

  return(sample)
}


#' Convert IP address to country and other info (region, city, zip) if requested
#' Making full == T automatically converts all info into TRUE
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
IP_country3 <- function(IP.address, IP.database = NULL, details = "min") {
  if(details == "min")
    return(IP_country(IP.address, IP.database = NULL))
  else if(details == "max"){
    return(IP_country2(IP.address, IP.database = NULL))
  }

}


