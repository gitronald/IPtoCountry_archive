# IPtoCountry
#### Tools for converting IP addresses to country names or IP integers
Default database is available by Creative Commons Attribution-ShareAlike 4.0 Interational license (CC-BY-SA 4.0).
This site or product includes IP2Location LITE data available from http://www.ip2location.com.


#### Features
* Fast IP address to country conversion utilizing functions from `data.table`

```
# Generate 1000 random IP addresses
test1000 <- IP_generator(1000)

microbenchmark(
  IP_country(test1000)
)

Unit: milliseconds
                          expr     min       lq    mean    median      uq      max neval
IP_country(IP_generator(1000)) 283.758 291.5897 313.7274 306.7513 321.172 437.1144   100

```


