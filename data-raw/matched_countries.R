library(devtools)

# Load hand matched country names
matched_countries = read.table("data-raw/matched_country_names.txt", sep= "\t", quote = "", header = TRUE)

# Clean extra quotes
matched_countries$IP.Countries = gsub("\"", "", matched_countries$IP.Countries)

# Save data
use_data(matched_countries)
