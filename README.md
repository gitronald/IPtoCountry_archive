# IPtoCountry
#### Tools for converting IP addresses to country names or IP integers
All of the IP address to location converters that are freely available online do not allow more
than a single IP address, or a small batch of IP addresses, to be processed at a given time. This
package provides an easy to use and flexible open source IP to location processor to solve that problem.

Default database is available by Creative Commons Attribution-ShareAlike 4.0 Interational license (CC-BY-SA 4.0).
This site or product includes IP2Location LITE data available from http://www.ip2location.com.



#### Features
* Fast IP address to country conversion utilizing functions from `data.table`

```
# Generate 1000 random IP addresses
test1000 <- IP_generator(1000)

# Check data
head(test1000)
[1] "9.191.255.116"   "122.157.198.66"  "187.88.189.255"  "119.181.105.132" "234.151.200.43"  "189.229.0.155"

IP_country(head(test1000))
[1] United States China         Brazil        China         -             Mexico

# Function timer
microbenchmark(
  IP_country(test1000)
)

Unit: milliseconds
                          expr     min       lq    mean    median      uq      max neval
IP_country(IP_generator(1000)) 283.758 291.5897 313.7274 306.7513 321.172 437.1144   100


```

#### Getting Started
Install the current version of this package by running `devtools::install_github("gitronald/IPtoCountry")` in `R`.


#### To Do
Here's our current to do list! Help, suggestions, and comments welcome.
* Add function for converting IP integer to IP address
* Add functions to handle IPv6 addresss
* Expand database capabilities with ip2locations other free datasets.
* Make IP.address input data.frame column compatible
* Add data type checks and warnings
