#' 2015 US Period Life Table
#' 
#' Probability of death within 1 year by age and sex in the United States in 2015.
#' 
#'
#' \itemize{
#'  \item age. Age strata, with each year a different stratum.
#'  \item sex. Male or Female.
#'  \item prob. Probability of death within 1 year given exact age and sex.
#' }
#'
#' @docType data
#'
#' @usage death_prob
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#'
#' @source \href{https://www.ssa.gov/oact/STATS/table4c6.html}{Social Security Administraton}
#' @examples
#' head(death_prob)
"death_prob"