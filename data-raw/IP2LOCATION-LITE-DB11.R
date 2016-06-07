# IP to country database
# http://download.ip2location.com/lite/
#
# DB1.LITE edition is licensed under Creative Commons
# Attribution-ShareAlike 4.0 International License
#
# This site or product includes IP2Location LITE data
# available from # http://lite.ip2location.com.
# IP2Location LITE Edition is free package with accuracy up to Class C (192.168.1.X) only.

ip2location.lite.db11 = read.table(unz("data-raw/IP2LOCATION-LITE-DB11.zip",
                                       "IP2LOCATION-LITE-DB11.CSV"),
                                       col.names = c("IPfrom", "IPto", "Abrv",
                                                     "Country", "Region", "City",
                                                     "Lat", "Long", "Zip", "GMT"),
                                   sep=",")

# devtools::use_data(ip2location.lite.db11, overwrite = T)

