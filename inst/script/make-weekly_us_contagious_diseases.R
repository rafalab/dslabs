library(readxl)
library(tidyverse)
library(stringr)
### To create this RDA you need access to the file tycho-us-infectious-disease-data.xlsx
### Which is currently not available from the web
### Once you have this file set path to the path of the file:
path <- "/Users/ririzarr/myDocuments/teaching/data-science/labs/vaccines/data"

### Read in tables
filename <- file.path(path,"tycho-us-infectious-disease-data.xlsx")
sheet_names <- excel_sheets(filename)
tables <- lapply(sheet_names, function(sheet) read_excel(filename, sheet = sheet, skip = 2, na = "-"))
names(tables) <- gsub(" ", "_", sheet_names)

## check if column names the same
tmp = sapply(tables, names)
if(!all(apply(tmp[,-1], 2, function(x) identical(tmp[,1], x)))) stop("column names not the same")

### Tidy each table
tables <- lapply(seq_along(tables), function(i) gather(tables[[i]], state, count, -YEAR, -WEEK) %>% mutate(disease = sheet_names[i]) %>%
                   .[,c(5,1:4)] %>%
                   mutate(state = str_to_title(state)))

## Combine into one big table
weekly_us_contagious_diseases <- Reduce(rbind,tables)
names(weekly_us_contagious_diseases  ) <- tolower(names(weekly_us_contagious_diseases  ))
weekly_us_contagious_diseases   <- weekly_us_contagious_diseases   %>% 
  mutate(state = str_to_title(state)) 

### Now get the population data from historydaata package
library("historydata")
data(us_state_populations)

## Function to interpolate population  between census years using a spline
interpolate_population <- function(state, xout){
  tmp <- us_state_populations[us_state_populations$state == state,] 
  min_year <- min(tmp$year)
  res <-with(tmp,round(exp(spline(year, log(population), method = "natural", xout = xout)$y)))
  res[xout<min_year] <- NA ## don't extrapolate to the past, state didnt exist  
  res
}

## Add population data to disease tidy table
weekly_us_contagious_diseases <- weekly_us_contagious_diseases %>% 
  group_by(state, disease) %>%
  mutate(time  = year + (week-1)/max(week)) %>%
  mutate(population = interpolate_population(state[1], time)) %>% 
  select(-time) %>%
  ungroup()

### Now take the totals for each year and the population at the start of the year
us_contagious_diseases <- weekly_us_contagious_diseases %>%
  group_by(disease, state, year) %>% arrange(year) %>%
  summarize(weeks_reporting = sum(!is.na(count)), count = sum(count, na.rm=TRUE),  population = population[1])

### turn into data frame and make some columns into factors
us_contagious_diseases <- data.frame(us_contagious_diseases)
us_contagious_diseases$state <- factor(us_contagious_diseases$state)
us_contagious_diseases$disease <- factor(us_contagious_diseases$disease)

save(us_contagious_diseases, file = "data/us_contagious_diseases.rda", compress="xz")
