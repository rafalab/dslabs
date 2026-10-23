# Regenerate the two "two countries example" wide-format teaching CSVs in
# inst/extdata/ from the reflavored global_tech_adoption dataset.
#
# These files are used by behdsbook-part-1's reshaping-data.qmd (and the
# tidy-data example in tidyverse.qmd) to teach pivot_longer / pivot_wider /
# separate_wider_delim. They were originally built from dslabs::gapminder's
# `fertility` and `life_expectancy` columns pulled from now-dead Google
# Spreadsheet URLs; they are now derived from global_tech_adoption instead:
#   fertility            -> avg_price_per_app_usd   (unchanged values)  -> `price`
#   life_expectancy      -> avg_daily_screen_time_hours (rescaled)      -> `screen_time`
#
# `price` is deliberately a single token and `screen_time` two tokens so the
# separate_wider_delim(too_many = "merge") lesson still has a "2 pieces vs
# 3 pieces" case to handle.
#
# Years are limited to 2008-2015: the app-store era (Apple's App Store and
# Android Market both opened in 2008). global_tech_adoption keeps gapminder's
# 1960-2016 years, which make no sense for app prices; 2016 has no price.

library(behdslabs)
library(dplyr)
library(tidyr)

countries <- c("Germany", "South Korea")

d <- global_tech_adoption |>
  filter(country %in% countries & year >= 2008 & year <= 2015) |>
  transmute(country, year,
            price = round(avg_price_per_app_usd, 2),
            screen_time = round(avg_daily_screen_time_hours, 2))

# 1. app price only, plain year column names
d |>
  select(country, year, price) |>
  pivot_wider(names_from = year, values_from = price) |>
  as.data.frame() |>
  write.csv("inst/extdata/app-price-two-countries-example.csv", row.names = FALSE)

# 2. app price AND screen time, "<year>_<variable>" column names
wide2 <- d |>
  pivot_wider(names_from = year, values_from = c(price, screen_time),
              names_glue = "{year}_{.value}") |>
  as.data.frame()
wide2 <- wide2[, c("country", sort(setdiff(names(wide2), "country")))]
write.csv(wide2, "inst/extdata/screentime-and-app-price-two-countries-example.csv",
          row.names = FALSE)
