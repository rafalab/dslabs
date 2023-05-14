#' Greenhouse gas concentrations over 2000 years
#' 
#' Concentrations of the three main greenhouse gases carbon dioxide, methane and nitrous oxide. Measurements are from the Law Dome Ice Core in Antarctica. Selected measurements are provided every 20 years from 1-2000 CE.
#'
#' \itemize{
#'  \item year. Year (CE).
#'  \item gas. Gas being measured: carbon dioxide (`CO2`), methane (`CH4`) or nitrous oxide (`N2O`). 
#'  \item concentration. Gas concentration in ppm by volume (`CO2`) or ppb by volume (`CH4`, `N2O`).
#' }
#'
#' @docType data
#'
#' @usage greenhouse_gases
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#'
#' @source MacFarling Meure et al. 2006 via \href{https://www.ncei.noaa.gov/access/paleo-search/study/9959/}{NOAA}.
#' 
#'
#' @examples
#' head(greenhouse_gases)
"greenhouse_gases"