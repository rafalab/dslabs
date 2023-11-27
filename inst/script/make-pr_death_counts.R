library(pdftools)
library(tidyverse)
library(lubridate)
library(purrr)
library(pdftools)

fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package = "dslabs")
x <- str_split(pdf_text(fn), "\n")
pr_death_counts <- map_df(x, function(s){
  s <- str_trim(s)
  header_index <- str_which(s, "2015")[1]
  tmp <- str_split(s[header_index], "\\s+", simplify = TRUE)
  month <- tmp[1]
  header <- tmp[-1]
  tail_index  <- str_which(s, "Total")
  n <- str_count(s, "\\d+")
  out <- c(1:header_index, which(n == 1), 
           which(n >= 28 & n <= 31), tail_index:length(s))
  s <- s[-out] |>  str_remove_all("[^\\d\\s]") |> str_trim() |>
    str_split_fixed("\\s+", n = 6) 
  s <- s[,1:5]
  colnames(s) <- c("day", header)
  s |> as_tibble(validate = FALSE) |> 
    mutate(month = month, day = as.numeric(day)) |>
    pivot_longer(-c(day, month), names_to = "year", values_to = "deaths") |>
    mutate(deaths = as.numeric(deaths))
}) |>  mutate(month = recode(month, 
                             "JAN" = 1, "FEB" = 2, "MAR" = 3, 
                             "APR" = 4, "MAY" = 5, "JUN" = 6, 
                             "JUL" = 7, "AGO" = 8, "SEP" = 9, 
                             "OCT" = 10, "NOV" = 11, "DEC" = 12)) |>
  mutate(date = make_date(year, month, day)) |>
  select(date, deaths) |>
  arrange(date)

  
save(pr_death_counts, file = "data/pr-death-counts.rda", compress = "xz", version = 2)
  