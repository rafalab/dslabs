library(dplyr)
library(readr)
library(readxl)
library(tidyr)
library(countrycode)

urls <- c("https://spreadsheets.google.com/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=csv",
          "https://spreadsheets.google.com/pub?key=phAwcNAVuyj2tPLxKvvnNPA&output=csv",
          "https://spreadsheets.google.com/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=csv",
          "https://spreadsheets.google.com/pub?key=phAwcNAVuyj0XOoBL_n5tAQ&output=csv",
          "https://spreadsheets.google.com/pub?key=phAwcNAVuyj1jiMAkmq1iMg&output=csv",
          "https://spreadsheets.google.com/pub?key=0AkBd6lyS3EmpdHo5S0J6ekhVOF9QaVhod05QSGV4T3c&output=csv")

names(urls) <- c("infant_mortality", "life_expectancy",
                 "fertility","population","income","gdp_per_capita")

tables <- lapply(urls, read_csv, na = c("", "NA", "-", "."))

##Tidy data
##Function to make column name for key uniform and
##change for wide to long format
fix_table <- function(tab, val_name){
  names(tab)[1] <- "country"
  tab <- filter(tab, !is.na(country))
  tab <- gather(tab, key=year, value=y, -country, convert = TRUE)
  names(tab)[which(names(tab)=="y")] <- val_name
  return(tab)
}
##Fix each table
for(i in seq_along(tables) ) tables[[i]] <-fix_table(tables[[i]], names(tables)[i])

##Join into one large table
gapminder <- Reduce(full_join, tables)
gapminder <- filter(gapminder, year>=1960)

### remove countries that dont have the data needed for the main figures
out <- gapminder %>% group_by(country) %>% summarize_at(c("infant_mortality","life_expectancy","fertility","income","gdp_per_capita"), function(x) all(is.na(x))) %>% 
  filter(life_expectancy | fertility | income | gdp_per_capita) %>% .$country
gapminder <- filter(gapminder, !country%in%out)
rm(tables); gc(verbose = FALSE)


oecd <- c("Australia","Austria","Belgium","Canada","Chile","Country","Czech Republic","Denmark","Estonia","Finland","France","Germany","Greece","Hungary","Iceland","Ireland","Israel","Italy","Japan","Korea","Luxembourg","Mexico","Netherlands","New Zealand","Norway","Poland","Portugal","Slovak Republic","Slovenia","Spain","Sweden","Switzerland","Turkey","United Kingdom","United States")
opec <- c("Algeria","Angola","Ecuador","Iran","Iraq","Kuwait","Libya","Nigeria","Qatar","Saudi Arabia","United Arab Emirates","Venezuela")
gapminder <- mutate(gapminder, region = factor(countrycode(country, "country.name", "region"))) %>% mutate(country = factor(country))

save(gpminder, oecd, opec, file="data/gapminder.rda")

