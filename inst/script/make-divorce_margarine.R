## Extracted from http://www.tylervigen.com/spurious-correlations
divorce_margarine<- data.frame(divorce_rate_maine = c(5, 4.7, 4.6, 4.4, 4.3, 4.1, 4.2, 4.2, 4.2, 3.7),
                   margarine_consumption_per_capita = c(8.2, 7, 6.5, 5.3, 5.2, 4, 4.6, 4.5, 4.2, 4.1),
                   year = 2000:2009) 

save(divorce_margarine, file="data/divorce_margarine.rda", compress="xz")