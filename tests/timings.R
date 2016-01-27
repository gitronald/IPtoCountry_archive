library(microbenchmark)

test1000 <- IP_generator(1000)

microbenchmark(
  IP_country(test1000)
)
# Unit: milliseconds
# expr     min       lq     mean   median      uq      max neval
# IP_country(IP_generator(1000)) 283.758 291.5897 313.7274 306.7513 321.172 437.1144   100


system.time(testdata <- IP_generator(1000000))

#  user  system elapsed
# 74.98    0.19   76.95

system.time(IP_country(testdata))

#  user  system elapsed
# 13.11    1.05   15.10
