#' Atmospheric carbon dioxide concentration over 800,000 years
#' 
#' Concentration of carbon dioxide in ppm by volume from direct measurements at Mauna Loa (1959-2018 CE) and indirect measurements from a series of Antarctic ice cores (approx. -800,000-2001 CE).
#' 
#'
#' \itemize{
#'  \item year. Year (CE).
#'  \item co2. Carbon dioxide concentration in ppm by volume.
#'  \item source. Source of carbon dioxide measurement: direct CO2 annual mean concentrations from Mauna Loa (`Mauna Loa`) or indirect CO2 concentrations from air trapped in ice cores (`Ice Cores`).
#' }
#'
#' @docType data
#'
#' @usage historic_co2
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#'
#' @source Mauna Loa data from \href{https://gml.noaa.gov/ccgg/trends/data.html}{NOAA}. Ice core data from Bereiter et al. 2015 via \href{https://gml.noaa.gov/ccgg/trends/data.html}{NOAA}.
#' 
#'
#' @examples
#' head(historic_co2)
"historic_co2"