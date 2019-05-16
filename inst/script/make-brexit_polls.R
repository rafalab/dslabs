## Code written by Amy Gill

##Set working directory to package main directory
library(dplyr)
library(rvest)
library(readr)
library(stringr)
library(lubridate)

## get data from wikipedia
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
h <- read_html(url)
brexit_polls <- h %>% html_nodes("table") %>%
  html_table(fill=TRUE) %>% .[[7]] 

## change column names
brexit_polls <- brexit_polls[-1,]
names(brexit_polls) <- c("last_date", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")

## rows with noe data and not including the ninth column: the notes column 
brexit_polls <- brexit_polls[-which(!grepl("%", brexit_polls$remain)), 1:8]

## getting start and end dates
dates <- brexit_polls$last_date
end <- str_extract(dates, "\\d+\\s[a-zA-Z]+")
start_day <- str_extract(dates, "^\\d{1,2}")
months <- str_extract_all(dates, "[a-zA-Z]{3,4}", simplify = TRUE)
end <- paste(end, "2016")
enddate <- dmy(end)
startdate <- ymd(paste(year(enddate), months[,1], start_day))
brexit_polls$enddate <- enddate
brexit_polls$startdate <- startdate

#remove final results line
brexit_polls <- brexit_polls[-1,]

## remove lead columns which is redundant
brexit_polls <- select(brexit_polls, -c("lead", "last_date"))

## convert poll percentages to proportions
brexit_polls$remain <- parse_number(brexit_polls$remain) / 100
brexit_polls$leave <- parse_number(brexit_polls$leave) / 100
brexit_polls$undecided <- brexit_polls$undecided %>% 
  str_replace_all("N/A", "0") %>%
  parse_number %>% 
  "/"(100)

## conver pretty numbers to actual numbers and take out poll with no sample size
brexit_polls <- brexit_polls %>% filter(samplesize != "N/A") %>%
  mutate(samplesize = parse_number(samplesize))

## conver pollsters to factors
brexit_polls$pollster <- factor(brexit_polls$pollster)
brexit_polls$poll_type <- factor(brexit_polls$poll_type)

## compute the spread
brexit_polls <- brexit_polls %>%
  mutate(spread = remain - leave)

brexit_polls <- brexit_polls[, c("startdate", "enddate", "pollster", "poll_type", "samplesize", "remain", "leave", "undecided", "spread")]


save(brexit_polls, file="data/brexit_polls.rda", compress = "xz")

