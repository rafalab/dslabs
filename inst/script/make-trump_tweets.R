## Download data
## remove '^"`  because these are retweets
## change the date a Data object
library(tidyverse)
library(lubridate)
library(tidytext)
library(textdata)

## The data was originally downloaded using the script below. 
## Last time we checked, on 2023/10/30, the website was no longer available.
# url <- 'http://www.trumptwitterarchive.com/data/realdonaldtrump/%s.json'
# trump_tweets <- map(2009:2017, ~sprintf(url, .x)) %>%
#   map_df(jsonlite::fromJSON, simplifyDataFrame = TRUE) %>%
#   filter(!is_retweet & !str_detect(text, '^"')) %>%
#   mutate(created_at = parse_date_time(created_at, orders = "a b! d! H!:M!:S! z!* Y!", tz="EST")) 
#save(trump_tweets, file="data/trump_tweets.rda", compress="xz")

load("data/trump_tweets.rda")

links <- "https://t.co/[A-Za-z\\d]+|&amp;"

nrc <- get_sentiments("nrc") |>
  select(word, sentiment)

sentiment_counts <- trump_tweets |> 
  extract(source, "source", "Twitter for (.*)") |>
  filter(source %in% c("Android", "iPhone") &
           created_at >= ymd("2015-06-17") & 
           created_at < ymd("2016-11-08")) |>
  filter(!is_retweet) |>
  arrange(created_at) |> 
  as_tibble() |>
  mutate(text = str_replace_all(text, links, ""))  |>
  unnest_tokens(word, text) |>
  filter(!word %in% stop_words$word &
           !str_detect(word, "^\\d+$")) |>
  mutate(word = str_replace(word, "^'", "")) |>
  left_join(nrc, by = "word", relationship = "many-to-many") |>
  count(source, sentiment) |>
  pivot_wider(names_from = "source", values_from = "n") |>
  mutate(sentiment = replace_na(sentiment, replace = "none"))


save(trump_tweets, sentiment_counts, file = "data/trump_tweets.rda",
     compress = "xz", version = 2)

