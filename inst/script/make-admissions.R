library(tidyverse)
library(rvest)

url <- "https://en.wikipedia.org/wiki/Simpson%27s_paradox#Berkeley_gender_bias_case"
h <- read_html(url)

admissions <- h %>% 
  html_nodes("table") %>% 
  .[[2]] %>% 
  html_table(fill=TRUE)  %>%
  setNames(tolower(c("major", paste(names(.)[-1], .[1,-1], sep="_")))) %>%
  slice(2:n()) %>%
  gather(key, value, -major) %>%
  separate(key, c("gender", "key"), "_")  %>%
  spread(key, value) %>% 
  arrange(gender) %>%
  mutate_at(c("admitted","applicants"), funs(parse_number)) %>%
  data.frame(., stringsAsFactors = FALSE)

save(admissions, file="data/admissions.rda", compress="xz")
