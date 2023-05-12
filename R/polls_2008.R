#' Poll data for popular vote in 2008 presidential election
#' 
#' Data from different pollsters for the popular vote between Obama and McCain 
#' in the 2008 presidential election.  
#'  
#'
#' \itemize{
#' \item day. Days until election day. Negative numbers are reported so that days can increase up to 0, which is election day.
#' \item margin. Average difference between Obama and McCain for that day.
#' }
#' 
#' @docType data
#'
#' @usage polls_2008
#'
#' @format An object of class \code{data.frame}.
#'  
#' @keywords datasets
#'
#'
#' @source \href{https://web.archive.org/web/20161108190914/http://www.pollster.com/08USPresGEMvO-2.html}{https://web.archive.org/web/20161108190914/http://www.pollster.com/08USPresGEMvO-2.html}
#'
#' @examples
#' with(polls_2008, plot(day, margin))
#' 
"polls_2008"
