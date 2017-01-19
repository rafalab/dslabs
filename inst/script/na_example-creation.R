##Set working directory to package main directory
set.seed(8)
na_example <- rpois(1000,2)
na_example[na_example==0] <- NA
save(na_example, file = "data/na_example.rda")
