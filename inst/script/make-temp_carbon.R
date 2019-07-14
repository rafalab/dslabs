library(tidyverse)

# import global tempearture anomaly data from NOAA
url <- "https://www.ncdc.noaa.gov/cag/global/time-series/globe/land_ocean/ytd/12/1880-2019.csv"
temps <- read_csv(url, skip = 4)
colnames(temps) = c("year", "temp_anomaly")

# import land temperature anomaly data from NOAA
url <- "https://www.ncdc.noaa.gov/cag/global/time-series/globe/land/ytd/12/1880-2019.csv"
land_temps <- read_csv(url, skip = 4)
colnames(land_temps) <- c("year", "land_anomaly")

# import ocean temperature anomaly data from NOAA
url <- "https://www.ncdc.noaa.gov/cag/global/time-series/globe/ocean/ytd/12/1880-2019.csv"
ocean_temps <- read_csv(url, skip = 4)
colnames(ocean_temps) <- c("year", "ocean_anomaly")

# combine temperature anomaly data
temps <- left_join(temps, land_temps, by = "year")
temps <- left_join(temps, ocean_temps, by = "year")

# import CO2 emissions data from CDIAC - selected columns were manually removed before import to avoid parsing failures
# original data: https://cdiac.ess-dive.lbl.gov/trends/emis/tre_glob_2014.html
Carbon_Emissions <- read_csv("inst/extdata/carbon_emissions.csv")

# rename columns
names(Carbon_Emissions) <- c("year","carbon_emissions")

# merge temps, Carbon_Emissions
temp_carbon <- full_join(temps, Carbon_Emissions, by = "year")

# remove temporary objects
rm(Carbon_Emissions, temps, land_temps, ocean_temps, url)

# make data frame
temp_carbon <- as.data.frame(temp_carbon)

# save to rda
save(temp_carbon, file = "data/temp_carbon.rda", compress = "xz")
