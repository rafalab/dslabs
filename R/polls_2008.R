#' Poll data for popular vote in 2008 presidential election
#' 
#' Data from different pollsters for the popular vote between Obama and McCain 
#' in the 20008 presidential election.  
#'  
#'
#' \itemize{
#' \item pollster. Name of the pollster. 
#' \item start_date. Start data of the poll. 
#' \item end_date. End date of the poll. 
#' \item n. Sample size of the poll.
#' \item population_type. Type of population that was polled.
#' \item mccain. Proportion obtained by McCain. 
#' \item obama. Proportion obtained by Obama.
#' \item barr. Proportion obtained by Barr. 
#' \item nader. Proportion obtained by Nader. 
#' \item other. Proportion obtained by other candidates. 
#' \item undecided. Proportion undecided. 
#' \item margin. Difference between Obama and McCain.
#' \item day. Days to election until election day. Negative numbers are reported to show day is before the election.
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
#' boxplot(margin ~ pollster, data = polls_2008, las = 2)
#' 
"polls_2008"
