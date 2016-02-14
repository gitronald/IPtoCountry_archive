# Create a single sample IP
x <- IP_generator(1)

# Create method for splitting an IP address values into matrix (pulled from IP_integer):
IP_binary <- function(IP.address) {
  IPa <- as.character(IP.address)  # Convert value(s) to character
  IPs <- strsplit(IPa, "\\.")      # Split on "." ("\\" used for special characters)
  IPs <- lapply(IPs, function(x) {
    binary_vector <- rev(as.numeric(intToBits(x)))
    binary_vector <- binary_vector[-(1:(length(binary_vector) - 8))]
    return(binary_vector)
    })                             # Reverses order of numeric bits and 
                                   # removes 24 leading bits
  IPs <- do.call(rbind, IPs)       # Rbind lists to matrix
  return(IPs)                      # Return IP data.frame
}