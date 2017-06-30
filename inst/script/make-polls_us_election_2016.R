library(readr)
library(tidyverse)
library(stringr)

##polls
url <- "http://projects.fivethirtyeight.com/general-model/president_general_polls_2016.csv"
polls_us_election_2016 <- read_csv(url)
polls_us_election_2016 <- filter(polls_us_election_2016, type=="polls-plus")
polls_us_election_2016$startdate <- as.Date(polls_us_election_2016$startdate,"%m/%d/%Y") ##turn enddate into date
polls_us_election_2016$enddate <- as.Date(polls_us_election_2016$enddate,"%m/%d/%Y") 
polls_us_election_2016 <- select(polls_us_election_2016, state, startdate, enddate, pollster, grade, samplesize, population, rawpoll_clinton, rawpoll_trump, rawpoll_johnson, rawpoll_mcmullin, adjpoll_clinton, adjpoll_trump, adjpoll_johnson, adjpoll_mcmullin)
polls_us_election_2016 <- as.data.frame(polls_us_election_2016)
polls_us_election_2016 <- mutate(polls_us_election_2016, 
                                 state = factor(state), 
                                 pollster = factor(pollster), 
                                 grade=factor(grade, levels = c("D","C-","C","C+","B-","B","B+","A-","A","A+")))

##2016 results
library(googlesheets)
url <- "https://docs.google.com/spreadsheets/d/1zxyOQDjNOJS_UkzerorUCf2OAdcMcIQEwRciKuYBIZ4/pubhtml?widget=true&headers=false#gid=658726802"
key <- extract_key_from_url(url)
gs <- gs_key(key)
tmp <- gs_read(gs, ws = "President", range = cell_cols(c(1:10)))
tmp <- tmp[-c(1:2),]
results_us_election_2016 <- 
  data.frame(state=tmp[[1]], 
             electoral_votes=tmp[[2]],
             clinton=as.numeric(gsub("%","",tmp[[7]])),
             trump=as.numeric(gsub("%","",tmp[[8]])),
             others=as.numeric(gsub("%","",tmp[[9]])),
             stringsAsFactors = FALSE) %>%
  mutate(state = ifelse(state == "Washington, D.C.", "District of Columbia", state))
  
save(polls_us_election_2016, results_us_election_2016, file = "data/polls_us_election_2016.rda", compress="xz")
