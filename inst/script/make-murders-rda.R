##Set working directory to package main directory
library(dplyr)
library(rvest)
library(readr)
library(stringr)

### US murders 2010

url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
us_murders <- h %>% html_nodes("table") %>%  
  html_table %>% .[[1]] %>% 
  tbl_df %>% setNames(c("state", "population", "population_density", 
                        "murders", "gun_murders", "gun_ownership", "murder_rate", "gun_murder_rate"))

to_parse_number <- names(us_murders)[-1]
us_murders %>% mutate_at(to_parse_number, parse_number)

columns_to_add <- data_frame(state = c(state.name, "District of Columbia"),
                             abb = c(state.abb,"DC"),
                             region = factor( c(as.character(state.region), "South"), 
                                              levels = levels(state.region)))

us_murders <- full_join(us_murders, columns_to_add, by = "state")

murders <- with(us_murders,
                data.frame(state = state,
                      abb = abb,
                      region = region,
                      population = parse_number(population),
                      total = parse_number(us_murders$gun_murders),
                      stringsAsFactors = FALSE))

save(murders, file = "data/murders.rda")
                