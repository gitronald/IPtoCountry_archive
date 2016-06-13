# Merge map data and IP data

library(maps)
library(ggplot2)
mapData = map_data("world")


ipData = read.table("lab/random_ips_dft", sep = "\t", quote = "", header = T, stringsAsFactors = F)
countryNames = read.table("lab/matched_country_names.txt", sep = "\t", quote = "", header = T, stringsAsFactors = F)
countryNames$IP.Countries = gsub("\"", "", countryNames$IP.Countries)


# Change IP data names to match Map data
for(i in 1:nrow(countryNames)){
  if(!is.na(countryNames[i, "IP.Countries"])){
    old.name <- paste(countryNames[i, "IP.Countries"])
    new.name <- paste(countryNames[i, "Matched.Countries"])
    ipData[, "group"] <- gsub(old.name, new.name, ipData[, "group"])
  }
}

# Aggregate repeat country names
ipData = aggregate(ipData[c('n', 'prop')], by=ipData['group'], sum)

# Merge
worldMapIPs <- merge(mapData, ipData, by.x = "region", by.y = "group", all.x = TRUE)
# Reorder plot points
worldMapIPs <- worldMapIPs[order(worldMapIPs[, "order"]), ]
# Replace NA with zero
worldMapIPs[is.na(worldMapIPs)] <- 0



# Plot --------------------------------------------------------------------



# Generate Blank World Map
world <- map_data("world")

p <- ggplot() +
  geom_polygon(data=world, aes(x=long, y=lat, group = group),
               colour = "gray70",                             # Country boundary outline
               fill = "#F9F9F9") +                            # Country fill
  theme(panel.background = element_rect(fill = "gray20"),     # Image frame color
        plot.background = element_rect(fill = "gray20"))      # Ocean color

# Plot data on blank map
plot1 <- p + geom_polygon(data=worldMapIPs,                                  # Fill countries
                          aes(x=long, y=lat, group = group, fill = prop)) +
  geom_path(data=worldMapIPs,
            aes(x=long, y=lat, group=group), color="black", size=0.3) +      # Fill borders
  scale_fill_gradient(low = "black", high = "#649AF1",                       # Fill color gradient
                      labels = scales::percent_format(),
                      limits = c(0,1)) +
  ggtitle(paste("Data Origins")) +
  theme(plot.title = element_text(size = 20, colour = "white", family = "sans",
                                  margin = unit(c(0, 0, 5, 0), "mm"))) +
  scale_y_continuous(name=NULL, breaks=NULL, expand = c(0,0)) +
  scale_x_continuous(name=NULL, breaks=NULL, expand = c(0,0)) +
  theme(legend.justification = c(0, 0),
        legend.position = c(0, 0.32),
        #         legend.background = element_rect(fill = "gray20"),
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = rel(1.1), colour = "white", family = "sans")) +
  guides(fill = guide_colorbar(barwidth = rel(0.5), barheight = rel(5.0), ticks = F))




# Save data ---------------------------------------------------------------


save(worldMapIPs, file = "lab/worldMapIPs.Rda")









