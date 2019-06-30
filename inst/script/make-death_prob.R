# import SSA period life expectancy tables
library(tidyverse)
death_prob <- read.csv("inst/extdata/ssa-death-probability.csv")
death_prob <- select(death_prob, "Age", "Sex", "DeathProb") %>%
  setNames(tolower(names(.))) %>%
  rename(prob = deathprob)

save(death_prob, file = "data/death_prob.rda", compress = "xz")
