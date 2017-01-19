##Set working directory to package main directory
set.seed(2)
na_example <- rpois(1000,2)
na_example[na_example==0] <- NA
sum(is.na(na_example))
head(na_example)
save(na_example, file = "data/na_example.rda")
