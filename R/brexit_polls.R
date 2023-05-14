#' Brexit Poll Data
#' 
#' Brexit (EU referendum) poll outcomes for 127 polls from January 2016 to the referendum date on June 23, 2016.
#'
#'
#' \itemize{
#'  \item startdate. Start date of poll.
#'  \item enddate. End date of poll.
#'  \item pollster. Pollster conducting the poll.
#'  \item poll_type. Online or telephone poll.
#'  \item samplesize. Sample size of poll.
#'  \item remain. Proportion voting Remain.
#'  \item leave. Proportion voting Leave.
#'  \item undecided. Proportion of undecided voters.
#'  \item spread. Spread calculated as remain - leave.
#' }
#'
#'
#' @docType data
#'
#' @usage brexit_polls
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#' 
#' @source \href{https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054/}{Wikipedia}
#'
#' @examples
#' head(brexit_polls)
"brexit_polls"