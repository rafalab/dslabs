#' dslabs theme set 
#'
#' This function sets a ggplot2 theme used throughout the data science labs. It can be called without arguments.
#'
#' @param new a prebuilt ggplot2 theme. Defaults to \code{"theme_minimal"}
#' @param args the arguments to be passed along to the ggplot2 theme function. Defaults to \code{"NULL"}.
#' @param base_size if \code{"args"} is \code{"NULL"}, base_size is one of the arguments passed to the theme function. It defaults to 11.
#' @param bold_title if TRUE, sets titles to be bold
#' @param ... additional arguments to be used by theme
#'  
#' @return None
#'
#' @examples
#' library(ggplot2)
#' ds_theme_set()
#' qplot(hp, mpg, data=mtcars, color=am, facets=gear~cyl, 
#' main="Scatterplots of MPG vs. Horsepower", 
#' xlab="Horsepower", ylab="Miles per Gallon")
#'
#' @export
#' 
ds_theme_set <- function(new = "theme_bw", args = NULL,
                         base_size = 11, 
                         bold_title = TRUE, 
                         ...){
  requireNamespace("ggplot2")
  
  if(! "package:ggplot2" %in% search() ) stop("ggplot2 must be loaded.\nLoad with library(ggplot2) or library(tidyverse).")
  
  if(is.null(args)) args <- list(base_size=base_size)
  
  th <- do.call(new, args) + ggplot2::theme(...)
  ggplot2::theme_set(th)
  
  if(bold_title) ggplot2::theme_update(plot.title=ggplot2::element_text(face="bold"))
}
