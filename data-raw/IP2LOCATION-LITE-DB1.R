# IP to country database
# http://download.ip2location.com/lite/
#
# DB1.LITE edition is licensed under Creative Commons
# Attribution-ShareAlike 4.0 International License
#
# This site or product includes IP2Location LITE data
# available from # http://lite.ip2location.com.


IPdatabase <- read.table("data-raw/IP2LOCATION-LITE-DB1.CSV",
                         col.names = c("IPfrom", "IPto", "Abrv", "Country"),
                         sep = ",")

devtools::use_data(IPdatabase)
