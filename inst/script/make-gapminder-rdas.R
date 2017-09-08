library(dplyr)
library(readr)
library(readxl)
library(tidyr)
library(countrycode)


## Note that the location of these files change
## You might have to go here https://www.gapminder.org/data/ and find the new links
urls <- c("https://spreadsheets.google.com/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=csv",
          "https://spreadsheets.google.com/pub?key=phAwcNAVuyj2tPLxKvvnNPA&output=csv",
          "https://spreadsheets.google.com/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=csv",
          "https://spreadsheets.google.com/pub?key=phAwcNAVuyj0XOoBL_n5tAQ&output=csv",
          "http://spreadsheets.google.com/pub?key=pyj6tScZqmEfI4sLVvEQtHw&output=csv")


names(urls) <- c("infant_mortality", "life_expectancy",
                 "fertility","population","gdp")

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
out <- gapminder %>% group_by(country) %>% summarize_at(c("infant_mortality","life_expectancy","fertility","gdp"), function(x) all(is.na(x))) %>% 
  filter(life_expectancy | fertility | gdp) %>% .$country
out <- c(out, "Channel Islands") ##removed because no information on continent or region. 
gapminder <- filter(gapminder, !country%in%out)

rm(tables); gc(verbose = FALSE)

## Add continent and region
gapminder <- mutate(gapminder, 
                    continent = factor(countrycode(country, "country.name", "continent")),
                    region = factor(countrycode(country, "country.name", "region"))) %>%
  mutate(country = factor(country))

gapminder <- as.data.frame(gapminder)

oecd <- c("Australia","Austria","Belgium","Canada","Chile","Country","Czech Republic","Denmark","Estonia","Finland","France","Germany","Greece","Hungary","Iceland","Ireland","Israel","Italy","Japan","Korea","Luxembourg","Mexico","Netherlands","New Zealand","Norway","Poland","Portugal","Slovak Republic","Slovenia","Spain","Sweden","Switzerland","Turkey","United Kingdom","United States")
opec <- c("Algeria","Angola","Ecuador","Iran","Iraq","Kuwait","Libya","Nigeria","Qatar","Saudi Arabia","United Arab Emirates","Venezuela")

save(gapminder, oecd, opec, file="data/gapminder.rda", compress="xz")

