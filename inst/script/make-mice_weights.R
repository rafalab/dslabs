library(tidyverse)
### Some columes in original file are not public
mice_weights <- read.csv("~/Downloads/svenson_pheno_to_rafael.csv") |>
  select(Sex, Diet, BW.12) |> 
  rename(sex = Sex, diet = Diet, body_weight = BW.12) |>
  mutate(sex = factor(sex), diet = factor(diet)) |>
  arrange(sex, diet) 

save(mice_weights, file="data/mice_weigths.rda", compress="xz", version = 2)

