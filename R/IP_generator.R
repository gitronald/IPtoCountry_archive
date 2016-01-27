IP_random <- function() {
  paste(sample(1:223, 1),
        sample(0:255, 1),
        sample(0:255, 1),
        sample(0:255, 1),
        sep = ".")
}

IP_generator <- function(n) {
  ips <- vector("list", n)
  ips <- lapply(ips, function(x) x <- IP_random())
  ips <- unlist(ips)

  return(ips)
}
