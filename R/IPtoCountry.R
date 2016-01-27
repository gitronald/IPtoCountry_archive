IP_country <- function(IPaddress) {
  # Convert IP address(es) to country(ies)
  #
  require(data.table)
  IPcode <- IPa2c(IPaddress)
  Country <- IPlookup(x=IPdatabase, y=IPcode)
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


