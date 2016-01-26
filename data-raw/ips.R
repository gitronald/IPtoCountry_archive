# Create test data

ips <- sample(paste(sample(1:223, 1),
                    sample(0:255, 1),
                    sample(0:255, 1),
                    sample(0:255, 1),
                    sep = "."),
              10000,
              replace = TRUE)

devtools::use_data(ips)
