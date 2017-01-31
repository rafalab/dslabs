##Set working directory to package main directory
library(RCurl)
library(tidyverse)
library(stringr)

tc <- getForm("https://docs.google.com/spreadsheet/pub", 
             hl ="en_US", key = "0ApvpBbD8HP4mdDlRUi1vdTlBQ3Rub2dJSUNVUDlDdVE", 
             output = "csv", 
             .opts = list(followlocation = TRUE, verbose = TRUE, ssl.verifypeer = FALSE)) 
reported_heights_1 <- read.csv(textConnection(tc), stringsAsFactors = FALSE)[,c(1,3,2)]
reported_heights_2 <- read.csv("https://raw.githubusercontent.com/datasciencelabs/data/master/bio260-heights.csv",
                              stringsAsFactors = FALSE)
names(reported_heights_1) <- names(reported_heights_2) <- c("time_stamp", "sex", "height")


reported_heights <- rbind(reported_heights_1,
                          reported_heights_2)

reported_heights <- filter(reported_heights, sex%in%c("Male","Female"))

save(reported_heights, file = "data/reported_heights.rda")
              
### Now clean it up

#we have to deal with meters, centimeters and heights in form a'b"
## we will wrange the heights out of string:
string <- reported_heights$height


##remove "cm", we will know when they are cm. Also get rid of spaces and "and"
string <- gsub("&|and|cm| ", "", string)

## changes words to numbers. Also small caps
map <- data.frame(number = 1:11, 
                  word = c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten","eleven"))
for(i in 1:nrow(map)) string <- gsub(map[i,2], map[i,1], tolower(string))

##change feet,ft to ' and inches, in to "
string <- gsub("inches|in","\"", string)  
string <- gsub("foot|feet|ft","\'", string)  
               
##The following three lines are to make convert a' or b" to a'b" format
##add 0 inches if 5' or 6' was reported
string <- ifelse(grepl("\\d'$", string), paste0(string,"0"), string)
##add 0 feet if 59 inches was reported. 
string <- ifelse(grepl("^\\d*\"", string), paste0("0'",string), string)

original <- suppressWarnings(as.numeric(string))
res <- str_match(string, "([\\d]+)[\']([\\d\\.]*)")
first <- as.numeric(res[,2])
second <- as.numeric(res[,3])
guess <- first*12 + second

in_range <- function(x, min_height=4.5, max_height=7){
  ifelse(is.na(x), FALSE, between(x, min_height*12, max_height*12))
}

height <- case_when(
  in_range(original) ~ original, ##inches
  in_range(original/2.54) ~ original/2.54, ##centimeters
  in_range(original*100/2.54) ~ original*100/2.54, ##meters
  in_range(guess) ~ guess) ##feet'inches''

heights <- data.frame(sex = reported_heights$sex, height = height)
heights <- filter(heights, !is.na(height))

## balance it between male and female
set.seed(1)
ind1 <- which(heights$sex=="Male")
ind2 <- which(heights$sex=="Female")
n <- min(c(length(ind1),length(ind2)))
ind <- c(sample(ind1,n), sample(ind2,n))
ind <- sample(ind)
heights <- heights[ind,]
rownames(heights) <- NULL

save(heights, file = "data/heights.rda")


