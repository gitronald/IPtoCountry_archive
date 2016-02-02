# IPtoCountry
#### Tools for converting IP addresses to country names or IP integers
Default database is available by Creative Commons Attribution-ShareAlike 4.0 Interational license (CC-BY-SA 4.0).
This site or product includes IP2Location LITE data available from http://www.ip2location.com.

All of the IP address to location converters that are freely available online do not allow more
than a single IP address, or a small batch of IP addresses, to be processed at a given time. This
package provides an easy to use and flexible open source IP to location processor to solve that problem.


#### Features
* Fast IP address to country conversion utilizing functions from `data.table`

```
# Generate 1000 random IP addresses
test1000 <- IP_generator(1000)

# Check data
head(test1000)
[1] "234.160.189.251" "176.87.95.73"    "47.27.142.229"   "193.137.76.182"  "166.179.78.179"  "116.94.105.167"

# Function timer
microbenchmark(
  IP_country(test1000)
)

Unit: milliseconds
                          expr     min       lq    mean    median      uq      max neval
IP_country(IP_generator(1000)) 283.758 291.5897 313.7274 306.7513 321.172 437.1144   100

```

#### Getting Started
Install the current version of this package by running `devtools::install_github("gitronald/IPtoCountry")`.


#### To Do
Here's our current to do list! Help, suggestions, and comments welcome.
* Convert IP address to binary
* Convert IP integer back to IP address
* Handle IPv6 addresss
* Expanded database capabilities with ip2locations other free datasets.
* Make IP.address input data.frame column compatible
* Add data type checks and warnings
