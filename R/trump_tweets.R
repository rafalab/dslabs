#' Trump Tweets from2009 to 2017
#' 
#' All tweets from Donald Trump's twitter account from 2009 to 2017 composed on Android or iPhone
#'
#' \itemize{
#' source. Device used to compose tweet.
#' id_str. Tweet ID.
#' text. Tweet.
#' created_at. Data and time tweet was tweeted.
#' retweet_count. How many times tweet had been retweeted at time dataset was created.
#' in_reply_to_user_id_str. If a reply, the user id of person being replied to.
#' favorite_count. Number of times tweet had been favored at time dataset was created.
#' is_retweet. A logical telling us if it is a retweet or not.
#' }
#' 
#' @docType data
#'
#' @usage data(trump_tweets)
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#' @source  The Trump Twitter Archive: \url{http://www.trumptwitterarchive.com}
#' 
#' @examples
#' data(trump_tweets)
#' head(trump_tweets)
#' 
"trump_tweets"
