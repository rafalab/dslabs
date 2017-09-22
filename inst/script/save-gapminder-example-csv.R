library(tidyverse)

tab <- read_csv("https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=csv",  na = c("", "NA", "-", "."))
countries <- c("South Korea","Germany")
names(tab)[1] <- "country"
tab <- tab %>% filter(country %in% countries) %>% select(country,`1960`:`2015`)
write.csv(tab, "inst/extdata/fertility-two-countries-example.csv", row.names = FALSE)

tab1 <- tab
tab2 <- read_csv("http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj2tPLxKvvnNPA&output=csv")
countries <- c("South Korea","Germany")
names(tab2)[1] <- "country"
tab2 <- tab2 %>% filter(country %in% countries) %>% select(country,`1960`:`2015`)

colnames(tab1)[-1] <- paste(colnames(tab1)[-1], "fertility", sep="_")
colnames(tab2)[-1] <- paste(colnames(tab2)[-1], "life_expectancy", sep="_")

tab3 <- full_join(tab1, tab2, by="country")
tab3 <- select(tab3, c("country", sort(names(tab3)[-1])))
write.csv(tab3, "inst/extdata/life-expectancy-and-fertility-two-countries-example.csv", row.names = FALSE)
