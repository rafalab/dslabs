library(tidyverse)

# import Mauna Loa annual mean CO2 concentrations from https://www.esrl.noaa.gov/gmd/ccgg/trends/data.html
url <- "ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt"
co2_mauna_loa <- read_table(url, skip = 56) %>%    # skip documentation
    select(year, co2 = mean) %>%    # keep annual mean CO2
    mutate(source = "Mauna Loa")    # label as Mauna Loa measurements

# import Antarctic Ice Cores Revised 800KYr CO2 Data: Bereiter et al. 2015: https://www.ncdc.noaa.gov/paleo-search/study/17975
url <- "https://www1.ncdc.noaa.gov/pub/data/paleo/icecore/antarctica/antarctica2015co2composite.txt"
co2_ice_cores <- read_tsv(url, skip = 137) %>%    # skip documentation
    mutate(year = round(-age_gas_calBP + 1950),    # convert year from calBP to CE
           source = "Ice Cores") %>%    # label as ice core measurements
    select(year, co2 = co2_ppm, source)    # keep CO2 ppm

# keep every 3rd measurement (reduce size of dataset)
rows <- seq(1, nrow(co2_ice_cores), 3)
co2_ice_cores <- co2_ice_cores[rows,]

# combine Mauna Loa and ice core CO2 measurements
historic_co2 <- rbind(co2_mauna_loa, co2_ice_cores)

# remove temporary objects
rm(co2_mauna_loa, co2_ice_cores)

# save as rda
save(historic_co2, file = "data/historic_co2.rda", compress = "xz")
