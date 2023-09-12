## Create a spreadsheet to practice wrangling with different encoding and locale
library(lubridate)
set.seed(2023 - 9 - 10)
original_time <- Sys.getlocale(category = "LC_TIME")
olocale <- Sys.getlocale()
Sys.setlocale("LC_TIME", "es_ES.UTF-8")
name <- c("Plácido", "João", "Beyoncé", "López", "Thalía", "Blümchen", "Ñengo") 
df <- data.frame(
  name = name,
  dob = format(c(make_date(1941, 1, 24),
                 make_date(1931, 6, 10),
                 make_date(1981, 9, 4),
                 make_date(1969, 7, 24), 
                 make_date(1971, 8, 26), 
                 make_date(1980, 4, 20),
                 make_date(1981, 12, 15)), "%d de %B de %Y"),
  stamp = make_datetime(
    year = year(today()),
    month = month(today()),
    day = day(today()),
    hour = sample(17:23, length(name), replace = TRUE),
    min = sample(0:59, length(name), replace = TRUE),
    sec = sample(0:59, length(name), replace = TRUE),
    tz = "America/New_York") |> with_tz(tz = "UTC")
)

df <- df[order(df$name),]
# Write the data frame to CSV in ISO-8859-1 encoding
write.csv(df, file = "inst/extdata/hw-submission-timestamps.csv", fileEncoding = "ISO-8859-1")

## test
Sys.setlocale("LC_TIME", original_time)

library(readr)
x <- read_csv("inst/extdata/hw-submission-timestamps.csv")
x <- read_csv("inst/extdata/hw-submission-timestamps.csv", locale = locale(encoding = "ISO-8859-1"))
parse_date(x$dob, format = "%d de %B de %Y", locale = locale(date_names = "es"))
parse_date(x$dob, format = "%d de %B de %Y", locale = locale(date_names = "es"))
with_tz(x$stamp, tz =  Sys.timezone())
