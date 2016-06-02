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
Internet Protocol (IP) addresses serve as the feelers upon which the Internet is able to connect computers and servers across great distances and within complicated clusters. These IP addresses come in two forms, IPv4 and IPv6:  
* Example IPv4 address: `180.20.23.162`  
* Example IPv6 address: `2001:0db8:0000:0042:0000:8a2e:0370:7334`  

As you might guess from the examples, IPv6 addresses are far more complex, and allow for far more possible combinations than IPv4. This is why they were built - to overcome the eventual exhaustion of available IPv4 addresses. Since that exhaustion hasn't happened yet, we will simply *ignore them*. 

### Determining the Location of IP Addresses
In order to figure out where an IP address is coming from, you need a recipe, or algorithm, for converting it.
The first step in the conversion algorithm is to split your IP addresses into *octets*

A formula for converting IP addresses to IP integer:

#### Step 1 - Split IP address into four octets  -------
``` {r}
> IP_split("180.20.23.162")
```
```{r}
         [,1] [,2] [,3] [,4]
ip.split  180   20   23  162
```

#### Step 2 - Calculate IP Integer from Octets  -------
* Long way
``` {r}
> Octet1 = 180
> Octet2 = 20
> Octet3 = 23
> Octet4 = 162
> (Octet1 * 256^3) + (Octet2 * 256^2) + (Octet3 * 256^1) + (Octet4 * 256^0)
```
``` {r}
[1] 3021215650
```
* Short way!
``` {r}
> IP_integer("180.20.23.162")
```
``` {r}
[1] 3021215650
```

#### Step 3 - Lookup Location Assigned to IP Integers in a Database  -------
``` {r}
> IP_lookup(3021215650)
```
``` {r}
[1] "Japan"
```

### IP_country - Fast IP address to country name conversion
* All of the above in one simple function
* Powered by `data.table`

``` {r}
> IP_country("180.20.23.162")

```
``` {r}
[1] Japan
Levels: Japan
```
### IP_generator - Fool your friends!
* Generate five random IP addresses
``` {r}
> IP_generator(5)

```
``` {r}
[1] "125.65.50.53"    "79.250.76.62"    "142.245.152.177" "230.76.201.42"   "107.182.57.171" 
```

### Speed
* Ludicrous speed, 33,333 IPs/sec feels like 666 km/sec.
``` {r}
> microbenchmark(IP_country(IP_generator(10000)))

```
``` {r}
Unit: milliseconds
                            expr      min       lq     mean   median       uq      max neval
 IP_country(IP_generator(10000)) 325.8086 364.2893 390.6751 383.0947 413.8585 500.9444   100

```



#### todo
* Finish IP_binary function and add reverse function
