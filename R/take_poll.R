#' Models results from taking a poll
#'
#' The function shows a plot of a random sample drawn from an urn with blue and red beads. The sample is taken with replacement. The proportion of blue beads is not shown so that students can try to estimate it.
#'
#' @param n Sample size
#' @param ... additional arguments to be used by the function \code{sample}.
#'
#' @return None
#'
#' @examples
#' take_poll(25)
#'
#' @export
#'

take_poll <- function(n, ...){
  .take_poll(n, ...)
}
