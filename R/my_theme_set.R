#' My theme set 
#'
#' Called without arguments, this function sets a ggplot2 theme used throughout the data science courses. 
#'
#' @param new a prebuilt theme. Defaults to theme_minimal
#' @param args the arguments to be passed along to the theme function. Defaults to \code{"NULL"}.
#' @param base_size if \code{"args"} is \code{"NULL"}, base_size is one of the arguments passed to the theme function. It defaults to 11.
#' @param base_family if \code{"args"} is \code{"NULL"}, base_family is one of the arguments passed to the theme function. It defaults to Helvetica.
#' @param bold_title it TRUE, sets titles to be bold
#' @param ... additional arguments to be used by theme_set
#'  
#' @return None
#'
#' @examples
#' library(ggplot2)
#' my_theme_set()
#' qplot(hp, mpg, data=mtcars, color=am, facets=gear~cyl, 
#' main="Scatterplots of MPG vs. Horsepower", 
#' xlab="Horsepower", ylab="Miles per Gallon")
#'
#' @export
#' 
my_theme_set <- function(new = "theme_minimal", args = NULL,
                         base_size = 11, base_family = "Helvetica", 
                         bold_title = TRUE, ...){
  requireNamespace("ggplot2")
  if(! "package:ggplot2" %in% search() ) stop("ggplot2 must be loaded.\nLoad with library(ggplot2) or library(tidyverse).")
  if(is.null(args)) args <- list(base_size=base_size, base_family=base_family)
  ggplot2::theme_set(do.call(new, args), ...)
  if(bold_title) ggplot2::theme_update(plot.title=ggplot2::element_text(face="bold"))
}
