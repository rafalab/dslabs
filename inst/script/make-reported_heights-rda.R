##Set working directory to package main directory
library(RCurl)
library(tidyverse)
library(stringr)
library(lubridate)

tc <- getForm("https://docs.google.com/spreadsheet/pub", 
             hl ="en_US", key = "0ApvpBbD8HP4mdDlRUi1vdTlBQ3Rub2dJSUNVUDlDdVE", 
             output = "csv", 
             .opts = list(followlocation = TRUE, verbose = TRUE, ssl.verifypeer = FALSE)) 
reported_heights_1 <- read.csv(textConnection(tc), stringsAsFactors = FALSE)[,c(1,3,2)]
reported_heights_2 <- read.csv("https://raw.githubusercontent.com/datasciencelabs/data/master/bio260-heights.csv",
                              stringsAsFactors = FALSE)

names(reported_heights_1) <- names(reported_heights_2) <- c("time_stamp", "sex", "height")

reported_heights_1  <- reported_heights_1 %>% mutate(time_stamp = mdy_hms(time_stamp))
reported_heights_2  <- reported_heights_2 %>% mutate(time_stamp = mdy_hms(time_stamp))


reported_heights <- bind_rows(reported_heights_1,
                          reported_heights_2)

## to help keep reproducible, remove entries from after the latest data
## from last time we saved the rda: "2017-10-14 14:07:51 UTC"

reported_heights <- filter(reported_heights, sex%in%c("Male","Female")) %>%
  filter(time_stamp <= "2017-10-14 14:07:51 UTC")  %>% arrange(time_stamp) %>%
  mutate(time_stamp = as.character(time_stamp))

save(reported_heights, file = "data/reported_heights.rda")
              
### Now clean it up
convert_format <- function(s){
  s %>%
    str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
    str_replace_all("inches|in|''|\"|cm|and", "") %>%  #remove inches and other symbols
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") %>% #change x.y, x,y x y
    str_replace("^([56])'?$", "\\1'0") %>% #add 0 when missing
    str_replace("^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2") %>% #change european decimal
    str_trim() #remove extra space
}

words_to_numbers <- function(s){
  s %>% 
    str_to_lower() %>%  
    str_replace_all("zero", "0") %>%
    str_replace_all("one", "1") %>%
    str_replace_all("two", "2") %>%
    str_replace_all("three", "3") %>%
    str_replace_all("four", "4") %>%
    str_replace_all("five", "5") %>%
    str_replace_all("six", "6") %>%
    str_replace_all("seven", "7") %>%
    str_replace_all("eight", "8") %>%
    str_replace_all("nine", "9") %>%
    str_replace_all("ten", "10") %>%
    str_replace_all("eleven", "11")
}

## Now convert all heights
pattern <- "^([4-7])\\s*'\\s*(\\d+\\.?\\d*)$"

smallest <- 50
tallest <- 84
new_heights <- reported_heights %>% 
  mutate(original = height, 
         height = words_to_numbers(height) %>% convert_format()) %>%
  extract(height, c("feet", "inches"), regex = pattern, remove = FALSE) %>% 
  mutate_at(c("height", "feet", "inches"), as.numeric) %>%
  mutate(guess = 12*feet + inches) %>%
  mutate(height = case_when(
    !is.na(height) & between(height, smallest, tallest) ~ height, #inches 
    !is.na(height) & between(height/2.54, smallest, tallest) ~ height/2.54, #centimeters
    !is.na(height) & between(height*100/2.54, smallest, tallest) ~ height*100/2.54, #meters
    !is.na(guess) & inches < 12 & between(guess, smallest, tallest) ~ guess, #feet'inches
    TRUE ~ as.numeric(NA))) %>%
  select(-guess)

heights <- data.frame(sex = reported_heights$sex, height = new_heights$height)
heights <- filter(heights, !is.na(height))

## balance it between male and female
rownames(heights) <- NULL

save(heights, file = "data/heights.rda")


