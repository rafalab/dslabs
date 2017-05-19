#' Models results from taking a poll
#'
#' The function shows a plot of a random sample from an urn of blue and red beads. The sample is taken with replacement. The proportion of blue beads is not shown so that students can try to estimate it.
#'
#' @param n the sample size
#' @param ... additional arguments to be used by the function that generates the 
#'
#' @return None
#'
#' @examples
#' library(ggplot2)
#' take_poll(25)
#'
#' @export
#'

take_poll <- function(n, ...){
  .take_poll(n, ...)
}
