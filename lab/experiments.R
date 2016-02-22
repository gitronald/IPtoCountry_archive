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



