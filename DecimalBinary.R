# Takes each component of decimals vector and converts it to raw bits vector.
# This vector is then converted to an integer vector 8 bits long.
IP <- c(75,80,55,181)
m <- sapply(IP, function(x) {
  binary_vector <- rev(as.numeric(intToBits(x)))
  return(binary_vector[-(1:(length(binary_vector) - 8))])
  }
)

# Takes 4 8 bit vectors and combines them into 1 32 bit vector
n <- c(m[,1:4])

#
prompt <- "enter the experiment numbers (space-separated list) \n"
EXP <- as.integer(strsplit(readline(prompt), " ")[[1]])