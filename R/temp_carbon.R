#' Global temperature anomaly and carbon emissions, 1751-2018
#' 
#' Annual mean global temperature anomaly on land, sea and combined, 1880-2018. Annual global carbon emissions, 1751-2014.
#' 
#'
#' \itemize{
#'  \item Year. Year (CE).
#'  \item Temp_Anomaly. Global annual mean temperature anomaly in degrees Celsius relative to the 20th century mean temperature. 1880-2018. 
#'  \item Land_Anomaly. Annual mean temperature anomaly on land in degrees Celsius relative to the 20th century mean temperature. 1880-2018.
#'  \item Ocean_Anomaly. Annual mean temperature anomaly over ocean in degrees Celsius relative to the 20th century mean temperature. 1880-2018.
#'  \item Carbon_Emissions. Annual carbon emissions in millions of metric tons of carbon. 1751-2014.
#' }
#'
#' @docType data
#'
#' @usage data(temp_carbon)
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#'
#' @source \href{https://www.ncdc.noaa.gov/cag/global/time-series}{NOAA} and Boden, T.A., G. Marland, and R.J. Andres (2017) via \href{https://cdiac.ess-dive.lbl.gov/trends/emis/tre_glob_2014.html}{CDIAC}
#'
#' @examples
#' data(temp_carbon)
#' head(temp_carbon)
"temp_carbon"