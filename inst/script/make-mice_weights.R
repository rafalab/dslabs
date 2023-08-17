library(tidyverse)
mice_weights <- read.csv("/Users/rafa/myDocuments/teaching/data-science/labs/mouse-weights/svenson850_phenotypes_2021.csv.gz") |>
  filter(gen !=5 & !is.na(bw.19)) |> ## Gen 5 had no animals on high-fat diet
  select(bw.19,  bmd2, perc.fat2, sex, diet, gen, litter) |> 
  rename(body_weight = bw.19, bone_density = bmd2, percent_fat = perc.fat2 ) |>
  mutate(sex = factor(sex), diet = factor(diet), gen = as.factor(gen),
         litter = factor(litter)) |>
  filter(!is.na(body_weight))  |>
  arrange(diet, sex, gen, litter) 

save(mice_weights, file="data/mice_weigths.rda", compress="xz", version = 2)

