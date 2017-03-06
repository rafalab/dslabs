set.seed(1)
### heights in feet
outlier_example <- round(rnorm(500, 69/12, 3/12), 2)
## we pick a value that will be about 180 centimeters
o <- 219
outlier_example[o] <- round(outlier_example[o]*12*2.54/5)*5 ##mistake made in o-th measurement, centimeters, rounded to closest 5, reported
save(outlier_example, file = "data/outlier_example.rda")
