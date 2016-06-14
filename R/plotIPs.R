#' Convert IPs to countries and plot on world map
#'
#' @param IP.address a vector or column of IP addresses
#'
#' @return Returns a world map plot with gradient coloring reflecting the
#'   percentage of IP addresses originating in each country
#' @importFrom dtables dft
#' @importFrom ggplot2 map_data
#' @export
#'
#' @examples
#' plotIPs(IP.address)
plotIPs = function(IP.address) {

  mapData = map_data("world")
  sample_countries= IP_country(IP.address)

  sample_dft = dft(sample_countries, perc= F)

  ipData = sample_dft
  countryNames = matched_countries
  countryNames$IP.Countries = gsub("\"", "", countryNames$IP.Countries)


  #ipData = read.table("lab/random_ips_dft", sep = "\t", quote = "", header = T, stringsAsFactors = F)
  #countryNames = read.table("lab/matched_country_names.txt", sep = "\t", quote = "", header = T, stringsAsFactors = F)
  #countryNames$IP.Countries = gsub("\"", "", countryNames$IP.Countries)


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
                 colour = "#595959",                            # Country boundary outline
                 fill = "white") +                            # Country fill
    theme(panel.background = element_rect(fill = "#b3b3b3"),    # Image frame color
          plot.background = element_rect(fill = "#b3b3b3"))     # Ocean color

  # Plot data on blank map
  plot1 <- p + geom_polygon(data=worldMapIPs,                                  # Fill countries
                            aes(x=long, y=lat, group = group, fill = prop)) +
    geom_path(data=worldMapIPs,
              aes(x=long, y=lat, group=group), color="#595959", size=0.3) +      # Fill borders
    scale_fill_gradient(low = "white", high = "#000071",                       # Fill color gradient
                        labels = scales::percent_format(),
                        limits = c(0,1)) +
    ggtitle(paste("Data Origins")) +
    theme(plot.title = element_text(size = 20, colour = "black", family = "sans",
                                    margin = unit(c(0, 0, 5, 0), "mm"))) +
    scale_y_continuous(name=NULL, breaks=NULL, expand = c(0,0)) +
    scale_x_continuous(name=NULL, breaks=NULL, expand = c(0,0)) +
    theme(legend.justification = c(0, 0),
          legend.position = c(0, 0.32),
          #         legend.background = element_rect(fill = "gray20"),
          legend.background = element_blank(),
          legend.title = element_blank(),
          legend.text = element_text(size = rel(1.1), colour = "black", family = "sans")) +
    guides(fill = guide_colorbar(barwidth = rel(0.5), barheight = rel(5.0), ticks = F))
  return(plot1)
}

