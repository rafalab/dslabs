olives <- read.csv("inst/extdata/olive.csv")
olives$Area <- factor(olives[,1])
olives <- olives[,-1]
olives[ , -c(1,2)] <- olives[ , -c(1,2)]/100
region_names <- c("Southern Italy","Sardinia","Northern Italy")
olives$Region <- factor(region_names[olives$Region])
names(olives) <- tolower(names(olives))
save(olives, file="data/olives.rda", compress="xz")
