olive <- read.csv("inst/extdata/olive.csv")
olive$Area <- factor(olive[,1])
olive <- olive[,-1]
olive[ , -c(1,2)] <- olive[ , -c(1,2)]/100
region_names <- c("Southern Italy","Sardinia","Northern Italy")
olive$Region <- factor(region_names[olive$Region])
names(olive) <- tolower(names(olive))
save(olive, file="data/olive.rda", compress="xz")
