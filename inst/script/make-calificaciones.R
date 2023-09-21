## Create a spreadsheet to practice wrangling with different encoding and locale
library(lubridate)
set.seed(2023 - 9 - 10)
original_time <- Sys.getlocale(category = "LC_TIME")
olocale <- Sys.getlocale()
Sys.setlocale("LC_TIME", "es_ES.UTF-8")
nombre <- c("Plácido", "João", "Beyoncé", "López", "Thalía", "Blümchen", "Ñengo") 
df <- data.frame(
  nombre = nombre,
  f.n. = format(c(make_date(1941, 1, 24),
                 make_date(1931, 6, 10),
                 make_date(1981, 9, 4),
                 make_date(1969, 7, 24), 
                 make_date(1971, 8, 26), 
                 make_date(1980, 4, 20),
                 make_date(1981, 12, 15)), "%d de %B de %Y"),
  estampa = make_datetime(
    year = year(today()),
    month = month(today()),
    day = day(today()),
    hour = sample(17:23, length(nombre), replace = TRUE),
    min = sample(0:59, length(nombre), replace = TRUE),
    sec = sample(0:59, length(nombre), replace = TRUE),
    tz = "America/New_York") |> with_tz(tz = "UTC"),
  puntuación = format(round(runif(length(nombre),80,100),1), decimal.mark = ",")
)


df <- df[order(df$nombre),]
# Write the data frame to CSV in ISO-8859-1 encoding
write.csv(df, file = "inst/extdata/calificaciones.csv", fileEncoding = "ISO-8859-1",
          row.names = FALSE)

## test
Sys.setlocale("LC_TIME", original_time)

library(readr)
try({x <- read_csv("inst/extdata/calificaciones.csv")})
x <- read_csv("inst/extdata/calificaciones.csv", locale = locale(encoding = "ISO-8859-1", decimal_mark = ","))
parse_date(x$f.n., format = "%d de %B de %Y", locale = locale(date_names = "es"))
with_tz(x$estampa, tz =  Sys.timezone())
