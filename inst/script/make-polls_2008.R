library(tidyverse)
library(lubridate)
library(rvest)
url <- "https://web.archive.org/web/20160309010059/http://www.pollster.com/08USPresGEMvO-2.html"

polls_2008 <- read_html(url) %>%  
  html_node("table") %>%
  html_table(header=TRUE) %>%
  separate(col=Dates, into=c("start_date","end_date"), sep="-", fill="right") %>% 
  mutate(end_date = ifelse(is.na(end_date), start_date, end_date)) %>% 
  separate(start_date, c("smonth", "sday", "syear"), sep = "/",  convert = TRUE, fill = "right")%>% 
  mutate(end_date = ifelse(str_count(end_date, "/") == 1, paste(smonth, end_date, sep = "/"), end_date)) %>% 
  mutate(end_date = mdy(end_date))  %>% mutate(syear = ifelse(is.na(syear), year(end_date), syear + 2000)) %>% 
  unite(start_date, smonth, sday, syear)  %>% 
  mutate(start_date = mdy(start_date)) %>% 
  separate(`N/Pop`, into=c("N","population_type"), sep="\ ", convert=TRUE, fill="left") %>% 
  mutate(Obama = as.numeric(Obama)/100, 
         McCain=as.numeric(McCain)/100,
         Barr=as.numeric(na_if(Barr,"-"))/100,
         Nader=as.numeric(na_if(Nader,"-"))/100,
         Other=as.numeric(na_if(Other,"-"))/100,
         Undecided=as.numeric(na_if(Undecided,"-"))/100,
         Margin = Obama - McCain,
         Day = as.numeric(start_date - mdy("11/04/2008"))) %>%
  filter(start_date >= "2008-06-01") %>%
  group_by(day=Day)  %>% 
  summarize(margin=mean(Margin))
save(polls_2008, file = "data/polls_2008.rda", compress="xz")


