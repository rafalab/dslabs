#' Gapminder Data
#' 
#' Health and income outcomes for 184 countries from 1960 to 2016. Also includes two character verctors, oecd and opec, of OECD and OPEC countries from 2016.
#'
#' \itemize{
#'  \item country.  
#'  \item year.
#'  \item infant_mortality. Infant deaths per 1000.
#'  \item life_expectancy. Life expectancy in years.
#'  \item fertility. Average number of children per woman. 
#'  \item population. Country population.
#'  \item income. Average income for the country.
#'  \item gpd_per_capita. GDP per capita for the country.
#'  \item continent. 
#'  \item region. Geographical region.
#' }
#'
#'
#' @docType data
#'
#' @usage data(gapminder)
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#' 
#' @aliases oecd opec
#'
#' @examples
#' data(gapminder)
#' head(gapminder)
#' print(oecd)
#' print(opec)
"gapminder"

