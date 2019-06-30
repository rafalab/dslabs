# import greenhouse gas data for Law Dome Ice Core from NOAA
# citation: Etheridge, D.M., et al. 2010

library(tidyverse)

url <- "ftp://ftp.ncdc.noaa.gov/pub/data/paleo/icecore/antarctica/law/law2006.txt"
greenhouse_gases <- read_table(url, skip = 181)[1:2004,] %>%    # keep only the desired table
  select(Year = YearAD, CO2 = CO2spl, CH4 = CH4spl, N2O = N2Ospl) %>%    # rename gases
  gather(key = "Gas", value = "Concentration", -Year)  %>%    # change to tidy format
  filter(Year %in% seq(0, 2000, 20))  %>%  # keep every 20th year to reduce dataset size
  setNames(tolower(names(.)))
  
# save to rda
greenhouse_gases <- as.data.frame(greenhouse_gases) 
save(greenhouse_gases, file = "data/greenhouse_gases.rda", compress = "xz")
