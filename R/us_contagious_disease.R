#' Contagious Disease Data for US States
#' 
#' Yearly counts for Hepatitis A Measles, Mumps, Pertussis, Polio,  Rubella, and Small for US states. Original data courtesy of Tycho Project (http://www.tycho.pitt.edu/).
#'
#'
#'#' \itemize{
#'  \item disease. A factor containing name of disease.
#'  \item state. A factor containing stata name.
#'  \item year. 
#'  \item weeks_reporting. Number of weeks that reported counts that year.
#'  \item count. Total number of reported cases. 
#'  \item population. State population that year interpolated for non census years.
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