library(tidyverse)
library(stringr)
### To create this RDA you need access to the file ProjectTycho_Level1_v1.0.0.csv
### Which is currently available only after opening an account here: https://www.tycho.pitt.edu/
### And downloading from Level 1 Data here: https://www.tycho.pitt.edu/data/#datasets
### Once you have this file set path to the path of the file:
path <- "/Users/rafa/myDocuments/teaching/data-science/labs/vaccines/data"

### Read in tables
filename <- file.path(path, "ProjectTycho_Level1_v1.0.0.csv")
the_diseases <- c("Hepatitis A", "Measles", "Mumps", "Pertussis", "Polio", "Rubella", "Smallpox")
### Tidy each table
us_contagious_diseases <- read_csv(filename, na = "\\N") %>%
  distinct() %>% ## removing duplicate rows
  mutate(disease = str_to_title(disease)) %>% 
  filter(disease %in% the_diseases) %>%
  mutate(loc = factor(str_to_title(loc))) %>%
  mutate(year = floor(epi_week/100)) %>%
  mutate(week = epi_week - year*100) %>%
  group_by(disease, loc, year) %>% 
  summarize(weeks_reporting = sum(!is.na(cases)), count = sum(cases, na.rm=TRUE)) %>%
  ungroup() %>%
  group_by(disease) %>%
  complete(loc, year, fill = list(weeks_reporting = 0, count = 0)) %>%
  rename(state = loc)

library("historydata")
### Now get the population data from historydaata package
## Function to interpolate population  between census years using a spline
M <- max(us_contagious_diseases$year)
us_state_populations_ext <- 
  purrr::map_df(levels(us_contagious_diseases$state), function(x){
    dat <- filter(us_state_populations, state == x)
    data.frame(state = I(x),
             year = seq(min(dat$year), M),
             population = round(exp(spline(dat$year, log(dat$population), method = "natural",
                                                        xout = seq(min(dat$year), M))$y)))
}) %>% 
  mutate(state = factor(state))

## Add population data to disease tidy table
us_contagious_diseases <- left_join(us_contagious_diseases, us_state_populations_ext, by = c("state","year"))

### turn into data frame and make some columns into factors
us_contagious_diseases <- data.frame(us_contagious_diseases)
us_contagious_diseases$disease <- factor(us_contagious_diseases$disease)

save(us_contagious_diseases, file = "data/us_contagious_diseases.rda", compress="xz", version = 2)
