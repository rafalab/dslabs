#' Contagious disease data for US states
#' 
#' Yearly counts for Hepatitis A, Measles, Mumps, Pertussis, Polio,  Rubella, and Smallpox for US states. Original data courtesy of Tycho Project (http://www.tycho.pitt.edu/).
#'
#'
#' \itemize{
#'  \item disease. A factor containing disease names.
#'  \item state. A factor containing state names.
#'  \item year. 
#'  \item weeks_reporting. Number of weeks counts were reported that year.
#'  \item count. Total number of reported cases. 
#'  \item population. State population, interpolated for non-census years.
#' }
#
#' @docType data
#'
#' @usage us_contagious_diseases
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets 
#'
#' @references Willem G. van Panhuis, John Grefenstette, Su Yon Jung, Nian Shong Chok, Anne Cross, Heather Eng, Bruce Y Lee, Vladimir Zadorozhny, Shawn Brown, Derek Cummings, Donald S. Burke. Contagious Diseases in the United States from 1888 to the present. NEJM 2013; 369(22): 2152-2158.
#'
#' @source \href{http://www.tycho.pitt.edu/}{Tycho Project}
#'
#' @examples
#' head(us_contagious_diseases)
"us_contagious_diseases"
