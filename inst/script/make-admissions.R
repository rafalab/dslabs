olives <- read.csv("inst/extdata/olive.csv")
names(olives)[1] <- "area"
region_names <- c("Southern Italy","Sardinia","Northern Italy")
olives$Region <- factor(region_names[olives$Region])
names(olives) <- tolower(names(olives))
save(olives, file="data/olives.rda", compress="xz")
