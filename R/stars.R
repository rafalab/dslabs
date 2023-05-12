#' Physical Properties of Stars
#' 
#' Physical properties of selected stars, including luminosity, temperature, and spectral class.
#'
#'
#' \itemize{
#'  \item star. Name of star.
#'  \item magnitude. Absolute magnitude of the star, which is a function of the star's luminosity and distance to the star.
#'  \item temp. Surface temperature in degrees Kelvin (K).
#'  \item type. Spectral class of star in the OBAFGKM system.
#' }
#'
#' @docType data
#'
#' @usage stars
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#'
#' @source Compiled from multiple open-access references on \href{http://vizier.u-strasbg.fr/viz-bin/VizieR}{VizieR}.
#'
#' @examples
#' head(stars)
"stars"