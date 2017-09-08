library(tidyverse)

tab <- read_csv("https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=csv",  na = c("", "NA", "-", "."))
countries <- c("South Korea","Germany")
names(tab)[1] <- "country"
tab <- tab %>% filter(country %in% countries) %>% select(country,`1960`:`2015`)
write.csv(tab, "../extdata/fertility-two-countries-example.csv", row.names = FALSE)


