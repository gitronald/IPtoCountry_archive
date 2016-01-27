library(microbenchmark)

timing <- microbenchmark(
  IP_country(IP_generator(1000))
)
# Unit: milliseconds
# expr     min       lq     mean   median      uq      max neval
# IP_country(IP_generator(1000)) 283.758 291.5897 313.7274 306.7513 321.172 437.1144   100

system.time(IP_country(IP_generator(100000)))
