library(tidyverse)
library(readxl)

nyc_regents_scores <- read_excel("inst/extdata/2010_bigfive_regents.xls") %>% as.data.frame
nyc_regents_scores <- nyc_regents_scores[-c(1:2),]
names(nyc_regents_scores) <- gsub("\\.", "", gsub(" ", "_", tolower(names(nyc_regents_scores))))
rownames(nyc_regents_scores) <- NULL
names(nyc_regents_scores)[1] <- "score"
nyc_regents_scores$score[nyc_regents_scores$score == 999] <- NA
nyc_regents_scores$score <- as.numeric(nyc_regents_scores$score)
nyc_regents_scores

save(nyc_regents_scores, file = "data/nyc_regents_scores.rda", compress="xz")


