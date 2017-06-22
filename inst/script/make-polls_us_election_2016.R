library(readr)
library(tidyverse)
library(stringr)

##polls
url <- "http://projects.fivethirtyeight.com/general-model/president_general_polls_2016.csv"
polls_us_election_2016 <- read_csv(url)
polls_us_election_2016 <- filter(polls_us_election_2016, type=="polls-only")
polls_us_election_2016$startdate <- as.Date(polls_us_election_2016$startdate,"%m/%d/%Y") ##turn enddate into date
polls_us_election_2016$enddate <- as.Date(polls_us_election_2016$enddate,"%m/%d/%Y") 
polls_us_election_2016 <- select(polls_us_election_2016, state, startdate, enddate, pollster, grade, samplesize, population, rawpoll_clinton, rawpoll_trump, rawpoll_johnson, rawpoll_mcmullin)
polls_us_election_2016 <- as.data.frame(polls_us_election_2016)
polls_us_election_2016 <- mutate(polls_us_election_2016, 
                                 state = factor(state), 
                                 pollster = factor(pollster), 
                                 grade=factor(grade, levels = c("D","C-","C","C+","B-","B","B+","A-","A","A+")))

##electoral votes
us_electoral_votes_2016 <- read.csv("inst/extdata/us-electoral-votes-2016.csv", stringsAsFactors = FALSE)
names(us_electoral_votes_2016) <- tolower(names(us_electoral_votes_2016))
us_electoral_votes_2016 <- us_electoral_votes_2016[,-3] 
us_electoral_votes_2016 <- us_electoral_votes_2016[-20,] ##take out second Maine
us_electoral_votes_2016$votes[us_electoral_votes_2016$state=="Maine"] <- 2
us_electoral_votes_2016$votes[us_electoral_votes_2016$state=="Nebraska"] <- 2
add <- data.frame(state=c(paste0("Maine CD-",1:2), paste0("Nebraska CD-",1:3)), votes=rep(1,5))
us_electoral_votes_2016 <- rbind(us_electoral_votes_2016, add)
us_electoral_votes_2016 <- arrange(us_electoral_votes_2016, state)
us_electoral_votes_2016$state[us_electoral_votes_2016$state=="Lousiana"] <- "Louisiana"

save(us_electoral_votes_2016, polls_us_election_2016, file = "data/polls_us_election_2016.rda", compress="xz")
