#' Simulate falling object data
#'
#' The function simulates a falling object measurements.
#'
#' @param n. Sample size
#' @param d_0. Height from which object will fall in meters.
#' @param v_0. Initial velocity with which object will fall in meters per second.
#' @param g. Gravitational constnant, 9.8 meters per second per seonnd
#' @param scale. The measurement errors will be multiplied by this constant.
#' @param time. Numeric vector of times, in seconds, at which measurements were taken.
#' @param error_distribution. Character. Either `rnorm` for normal or `rt` for t-distribution.
#' @param df. If using t-distribution, the degrees of freedom.
#' 
#' @return A `data.frame` with the time, the distance travelled, and the observed distance.
#'
#' @examples
#' dat <- falling_object(10)
#' with(dat, plot(time, observed_distance))
#' with(dat, lines(time, distance, col = "blue))
#'
#' @export
#'

falling_object <- function(n, d_0 = 56.67, v_0 = 0, g = -9.8,  
                           scale = 1,
                           time = seq(0, 3.4, length.out = n),
                           error_distribution = c("rnorm", "rt"),
                           df = 3){
  error_distribution <- match.arg(error_distribution)
  error_func = get(error_distribution)
  d <- d_0 + v_0 * time + 0.5*g*time^2
  if(error_distribution == "rnorm"){
    y <- d  + rnorm(n)*scale
  } else{
    y <- d + rt(n, df = df) * scale
  }
  dat <- data.frame(time = time, distance = d, observed_distance = y)
  attr(dat, "params")  <- c(d_0 = d_0, v_0 = v_0, g = g, scale = scale)
  attr(dat, "error_distribution") <- error_distribution
  dat
}
