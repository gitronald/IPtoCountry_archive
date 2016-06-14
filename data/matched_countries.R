
matched_countries = read.csv("data/matched_country_names.txt", sep= "\t")

save(matched_countries, file = "data-raw/matched_country_names.rda")

