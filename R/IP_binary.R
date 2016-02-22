# Create a single sample IP
x <- IP_generator(1)

# Create method for splitting an IP address values into matrix 
# (pulled from IP_integer):
IP_binary <- function(IP.address) {
  IPs <- IP_split(IP.address)
  IPs <- split(IPs, seq(nrow(IPs)))
  
  IPs2 <- lapply(IPs, function(x) {
    lapply(x, function(y){
      binary_vector <- rev(as.numeric(intToBits(y)))
      binary_vector <- binary_vector[-(1:(length(binary_vector) - 8))]
    })
  })
  
  binary.collapse <- lapply(IPs2, function(x){
    lapply(x, paste, collapse = "")
  })
  
  binary.collapse <- lapply(binary.collapse, paste, collapse = "")
  return(binary.collapse)
}
