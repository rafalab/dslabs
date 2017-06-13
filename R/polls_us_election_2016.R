#' Fivethirtyeight 2016 Poll Data 
#' 
#' Poll results from US 2016 presidential elections aggregated from HuffPost Pollster, RealClearPolitics, polling firms and news reports. Original csv file is here: http://projects.fivethirtyeight.com/general-model/president_general_polls_2016.csv
#'
#'
#' \itemize{
#' \item state. State in which poll was taken. `U.S` is for national polls.
#' \item startdate. Poll's start data.
#' \item enddate. Poll's end data.
#' \item pollster. Pollster conducting the poll
#' \item grade. Grade assigned by fivethirtyeight to pollster.
#' \item samplesize. Sample size. 
#' \item population. Type of population being polled.
#' \item rawpoll_clinton. Percentage for Hillary Clinton.
#' \item rawpoll_trump. Percentage for Donald Trump
#' \item rawpoll_johnson. Percentage for Gary Johnson
#' \item rawpoll_mcmullin. Percentage for Evan McCullin.
#' }
#
#' @docType data
#'
#' @usage data(polls_us_election_2016)
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#'
#' @source \href{https://projects.fivethirtyeight.com/2016-election-forecast/?ex_cid=rrpromo}{Fivethirtyeight}
#'
#'
#' @examples
#' data(polls_us_election_2016)
#' head(polls_us_election_2016)
"polls_us_election_2016"