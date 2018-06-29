#' Poll data for popular vote in 2008 presidential election
#' 
#' Data from different pollsters for the popular vote between Obama and McCain 
#' in the 20008 presidential election.  
#'  
#'
#' \itemize{
#' \item day. Days to election until election day. Negative numbers are reported to show day is before the election.
#' \item margin. Average difference between Obama and McCain for that day.
#' }
#' 
#' @docType data
#'
#' @usage data(polls_2008)
#'
#' @format An object of class \code{data.frame}.
#'  
#' @keywords datasets
#'
#'
#' @source \href{https://web.archive.org/web/20160309010059/http://www.pollster.com/08USPresGEMvO-2.html}{https://web.archive.org/web/20160309010059/http://www.pollster.com/08USPresGEMvO-2.html}
#'
#' @examples
#' data(polls_2008)
#' with(polls_2008, plot(day, margin))
#' 
"polls_2008"
