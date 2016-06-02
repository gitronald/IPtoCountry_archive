# Shit is not picking up Canada. Need to examine matching function for bugs

library(maps)
world <- map_data("world")


# Obtain country names
i.names <- sort(unique(as.character(ip2location.lite.db1$Country)))
w.names <- sort(unique(as.character(world$region)))

# Detect mismatches
matched <- detect_merge_mismatch(w.names, i.names)

# Check remaining unmatched
# matched[[2]]; matched[[3]]
# Manually match:
manualmatch <- data.frame(matrix(
  c("Cape Verde", "Cabo Verde",
    "Democratic Republic of the Congo", "Congo, The Democratic Republic of The",
    "Republic of Congo", "Congo",
    "Ivory Coast", "Cote D'ivoire",
    "Laos", "Lao People's Democratic Republic",
    "North Korea", "Korea, Democratic People's Republic of",
    "South Korea", "Korea, Republic of",
    "UK", "United Kingdom",
    "USA", "United States",
    "Virgin Islands", "Virgin Islands, U.S.",
    "Vietnam", "Viet Nam"),
  ncol = 2,
  byrow = T
))
names(manualmatch) <- c("var1", "matches")
manualmatch <- apply(manualmatch, 2, as.character)

# Update unmatched
unmatched.w.names <- matched[["missing.var1"]][which(!matched[["missing.var1"]] %in% manualmatch[, "var1"])]
unmatched.i.names <- matched[["missing.var2"]][which(!matched[["missing.var2"]] %in% manualmatch[, "matches"])]
# Replace unmatched with manual matches
matched.final <- rbind(matched[["matched"]], manualmatch)
matched.final <- matched.final[!duplicated(matched.final["var1"], fromLast = TRUE), ]

# Reshape to ordered data.frame
matched.final <- data.frame(var1 = unlist(matched.final$var1),
                            matches = unlist(matched.final$matches),
                            stringsAsFactors = FALSE)
matched.final <- apply(matched.final, 2, as.character)
matched.final <- data.frame(matched.final[order(matched.final[, "var1"]), ],
                            stringsAsFactors = FALSE)

final <- list(matches = matched.final,
              unmatched.world.map = unmatched.w.names,
              unmatched.internet.penetration = unmatched.i.names)

# Generate Test IP data
a <- IP_country(IP_generator(50000))

for(i in 1:nrow(matched.final)){
  if(!is.na(matched.final[i, "matches"])){
    old.name <- paste(matched.final[i, "matches"])
    new.name <- paste(matched.final[i, "var1"])
    a <- gsub(old.name, new.name, a)
  }
}

library(dtables)
b <- dft(a)

c <- merge(world, b, by.x = "region", by.y = "group")
# Reorder plot points
c <- c[order(c[, "order"]), ]
# Replace NA with zero
# c[is.na(c)] <- 0

  world <- map_data("world")

    p <- ggplot() +
      geom_polygon(data=world, aes(x=long, y=lat, group = group),
                   colour = "gray70",                           # Country boundary outline
                   fill = "#F9F9F9") +                            # Country fill
      theme(panel.background = element_rect(fill = "gray20"),     # Image frame color
            plot.background = element_rect(fill = "gray20"))      # Ocean color

    plot1 <- p + geom_polygon(data=c,
                              aes_string(x="long", y="lat", group = "group", fill = "prop")) +
      scale_fill_gradient(low = "white", high = "#649AF1",
                          labels = scales::percent_format(),
                          limits = c(0,1)) +
      theme(plot.title = element_text(size = 20, colour = "white",
                                      margin = unit(c(0, 0, 5, 0), "mm"))) +
      scale_y_continuous(name=NULL, breaks=NULL, expand = c(0,0)) +
      scale_x_continuous(name=NULL, breaks=NULL, expand = c(0,0)) +
      theme(legend.justification = c(0, 0),
            legend.position = c(0, 0.32),
            #         legend.background = element_rect(fill = "gray20"),
            legend.background = element_blank(),
            legend.title = element_blank(),
            legend.text = element_text(size = rel(1.1), colour = "white") +
      guides(fill = guide_colorbar(barwidth = rel(0.5), barheight = rel(5.0), ticks = F))



# defines an IP address
IP <- c(75,80,55,181)

# Takes each decimal value of the IP address provided and converts it to an
# 8 bit binary string. The strings are then concatenated in IP_binary_string
IP_binary_string <- c(IP_dataframe <- sapply(IP, function(x) {
  binary_vector <- rev(as.numeric(intToBits(x)))
  return(binary_vector[-(1:(length(binary_vector) - 8))])
}
))


# New methods -------------------------------------------------------------

# Rough start/format example:
x <- 75
IP_binary <- function(x) {
  binary_vector <- rev(as.numeric(intToBits(x)))
  binary_vector <- binary_vector[-(1:(length(binary_vector) - 8))]
  return(binary_vector)
}

### Example

# Create a single sample IP
x <- IP_generator(1)

# Create method for splitting an IP address values into matrix (pulled from IP_integer):
IP_binary <- function(IP.address) {
  IPa <- as.character(IP.address)  # Convert value(s) to character
  IPs <- strsplit(IPa, "\\.")      # Split on "." ("\\" used for special characters)
  IPs <- lapply(IPs, as.numeric)   # Convert list(s) to numeric
  IPs <- do.call(rbind, IPs)       # Rbind lists to matrix
  return(IPs)                      # Return IP data.frame
}

# Test on sample
y <- IP_split(x)

# Proof of concept for IP_binary
lapply(y, function(x) as.numeric(intToBits(x))) # E.g. For each column of y, convert value to numeric binary

# JM update with binary converter
IP_split <- function(IP.address) {
  IPa <- as.character(IP.address)  # Convert value(s) to character
  IPs <- strsplit(IPa, "\\.")      # Split on "." ("\\" used for special characters)
  IPs <- lapply(IPs, function(x) {
    binary_vector <- rev(as.numeric(intToBits(x)))
    binary_vector <- binary_vector[-(1:(length(binary_vector) - 8))]
    return(binary_vector)
  })   # Convert list(s) to numeric
  IPs <- do.call(rbind, IPs)       # Rbind lists to matrix
  return(IPs)                      # Return IP data.frame
}

a <- IP_generator(20)
b <- strsplit(a, "\\.")
c <- do.call(rbind, b)



