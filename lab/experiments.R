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
  return(final)
}

IP_lookup3 <- function(IP.integer, IP.database = NULL) {
  if(is.null(IP.database)) IP.database <- ip2location.lite.db11
  DT <- setDT(IP.database)
  setkey(DT, IPfrom, IPto)
  DT2 <- data.table(IPfrom = IP.integer, IPto = IP.integer)
  res <- foverlaps(DT2, DT[, .(IPfrom, IPto)], type="within")
  res[, i:=seq_len(nrow(res))]
  setkey(res, i)
  final <- merge(res, DT, by=c("IPfrom", "IPto"))[order(i), .(Abrv, Country,
                                                              Region, City,
                                                              Zip, Lat, Long)]

  abrv <- as.vector(as.character(final[[1]]))
  country <- as.vector(as.character(final[[2]]))
  region <- as.vector(as.character(final[[3]]))
  city <- as.vector(as.character(final[[4]]))
  zip <- as.vector(as.character(final[[5]]))
  lat <- as.vector(as.character(final[[6]]))
  long <- as.vector(as.character(final[[7]]))

  final <- data.frame(country, region, city, zip)
  return(final)
}


# > microbenchmark(IP_lookup2(y), times = 50)
# Unit: seconds
#          expr      min       lq     mean   median       uq      max neval
# IP_lookup2(y) 3.765366 4.065012 4.346553 4.230587 4.633253 5.514791    50

# > microbenchmark(IP_lookup3(y), times = 50)
# Unit: seconds
#          expr      min       lq     mean   median      uq      max neval
# IP_lookup3(y) 3.456344 4.169457 4.598228 4.500778 4.97675 6.561262    50



####

# Might as well use all data if it's going to take a marginal amount more time









# Felix PullRequest: new database integration -----------------------------


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


#  ------------------------------------------------------------------------



