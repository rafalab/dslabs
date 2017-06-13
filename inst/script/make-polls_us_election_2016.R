library(readr)
library(tidyverse)
library(stringr)

url <- "http://projects.fivethirtyeight.com/general-model/president_general_polls_2016.csv"
polls_us_election_2016 <- read_csv(url)
polls_us_election_2016 <- filter(polls_us_election_2016, type=="polls-only")
polls_us_election_2016$startdate <- as.Date(polls_us_election_2016$startdate,"%m/%d/%Y") ##turn enddate into date
polls_us_election_2016$enddate <- as.Date(polls_us_election_2016$enddate,"%m/%d/%Y") 
polls_us_election_2016 <- select(polls_us_election_2016, state, startdate, enddate, pollster, grade, samplesize, population, rawpoll_clinton, rawpoll_trump, rawpoll_johnson, rawpoll_mcmullin)
polls_us_election_2016 <- as.data.frame(polls_us_election_2016)
polls_us_election_2016 <- mutate(polls_us_election_2016, state = factor(state), pollster = factor(pollster), grade=factor(grade), population=factor(population))

save(polls_us_election_2016, file = "data/polls_us_election_2016.rda")
