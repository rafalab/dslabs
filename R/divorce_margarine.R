#' Divorce rate and margarine consumption data
#' 
#' Divorce rates in Maine and per capita consumption of margarine in US data
#' 
#' 
#'
#' \itemize{
#'   \item divorce_rate_maine. Divorce per 1000 in Maine.
#'   \item margarine_consumption_per_capita. US per capita consumption of margarine in pounds.
#'   \item year. Year.
#' }
#'
#' @docType data
#'
#' @usage divorce_margarine
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source \href{https://www.tylervigen.com/spurious-correlations}{Spurious Correlations}
#'
#' @examples
#' with(divorce_margarine, plot(margarine_consumption_per_capita, divorce_rate_maine))
"divorce_margarine"
