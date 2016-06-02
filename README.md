# IPtoCountry

<!--
[![Build Status](https://travis-ci.org/gitronald/dtables.svg?branch=master)](https://travis-ci.org/gitronald/dtables)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/dtables)](http://cran.r-project.org/package=dtables)
--->

* A fast function for converting IP addresses (IPv4) to the country names they're located in.

<sub>Default database is available by Creative Commons Attribution-ShareAlike 4.0 Interational license (CC-BY-SA 4.0).  
This site or product includes IP2Location LITE data available from http://www.ip2location.com.</sub>

### Getting Started
``` {r}
devtools::install_github("gitronald/IPtoCountry")
library(IPtoCountry)
data(IPs)
```

### IP Addresses
Internet Protocol (IP) addresses serve as the backbone on which Internet is able to network and connect computers and servers across great distances and large crowds. These IP addresses come in two forms: IPv4 and IPv6.  
* Example IPv4 address: `180.20.23.162`  
* Example IPv6 address: `2001:0db8:0000:0042:0000:8a2e:0370:7334`  
As you might guess from the examples, IPv6 addresses are far more complex, and allow for far more possible combinations than IPv4. This is why they were built - to overcome the eventual exhaustion of available IPv4 addresses. Since that exhaustion hasn't happened yet, we will simply *ignore them*. 

### Determining the Location of IP Addresses
In order to figure out where an IP address is coming from, you need a recipe, or algorithm, for converting it.
The first step in the conversion algorithm is to split your IP addresses into *octets*

A formula for converting IP addresses to IP integer:

_Step 1 - Split IP address into four octets_
``` {r}
> IP.address = "180.20.23.162"
> IP_split(IP.address)
```
```
  ip.split
1      180
2       20
3       23
4      162
```

_Step 2 - Calculate IP Integer from Octets_
``` {r}
> Octet1 = 180
> Octet2 = 20
> Octet3 = 23
> Octet4 = 162
> IP.integer = (Octet1 * 256^3) + (Octet2 * 256^2) + (Octet3 * 256^1) + (Octet4 * 256^0)
> IP.integer
```
```
[1] 3021215650
```
OR just use the `IP_integer` function
``` {r}
> IP_integer("180.20.23.162")
```
```
[1] 3021215650
```

_Step 3 - Lookup Location Assigned to IP Integers in a Database_
``` {r}
> IP_lookup(3021215650)
```
```
[1] "Japan"
```

### IP_country - Fast IP address to country name conversion
* Powered by `data.table`

``` {r}
> IP_country(IPs[1])

```
```
[1] Netherlands
Levels: Netherlands
```
### IP_generator - Fool your friends!

``` {r}
# Generate 5 random IP addresses
> IP_generator(5)

```
```
[1] "125.65.50.53"    "79.250.76.62"    "142.245.152.177" "230.76.201.42"   "107.182.57.171" 
```

### SPEED
* Ludicrous speed, 33,333 IPs/sec feels like 666 km/sec.
```{r}
> microbenchmark(IP_country(IP_generator(10000)))

```
```
Unit: milliseconds
                            expr      min       lq     mean   median       uq      max neval
 IP_country(IP_generator(10000)) 325.8086 364.2893 390.6751 383.0947 413.8585 500.9444   100

```



#### To Do
Here's our current to do list! Help, suggestions, and comments welcome.
* Finish IP_binary function and add reverse function
