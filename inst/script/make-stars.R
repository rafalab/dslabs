# import stars data for HR diagram 
library(tidyverse)
stars <- read.table("inst/extdata/HRlist2.txt")
names(stars) <- c("star", "magnitude", "temp", "type")
stars$type <- str_remove(stars$type, "[^A-Z]+")
save(stars, file = "data/stars.rda", compress = "xz")
