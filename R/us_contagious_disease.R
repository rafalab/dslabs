#' Contagious disease data for US states
#' 
#' Yearly counts for Hepatitis A, Measles, Mumps, Pertussis, Polio,  Rubella, and Small for US states. Original data courtesy of Tycho Project (http://www.tycho.pitt.edu/).
#'
#'
#'#' \itemize{
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
#' @usage data(us_contagious_diseases)
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#'
#' @source \href{http://www.tycho.pitt.edu/}{Tycho Project}
#'
#' @examples
#' data(us_contagious_diseases)
#' head(us_contagious_diseases)
"us_contagious_diseases"