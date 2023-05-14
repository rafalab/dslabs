#' Movie ratings 
#' 
#' MovieLens Latest Dataset (Small)
#'
#' \itemize{
#' \item movieId. Unique ID for the movie.
#' \item title. Movie title (not unique). 
#' \item year. Year the movie was released.
#' \item genres. Genres associated with the movie.
#' \item userId. Unique ID for the user. 
#' \item rating. A rating between 0 and 5 for the movie.
#' \item timestamp. Date and time the rating was given.
#' }
#
#' @docType data
#' 
#' @usage movielens
#'
#' @format Two object of class \code{data.frame}. 
#'
#' @keywords datasets
#' 
#' @references 
#' F. Maxwell Harper and Joseph A. Konstan. 2015. The MovieLens Datasets: History and Context. ACM Transactions on Interactive Intelligent Systems (TiiS) 5, 4, Article 19 (December 2015), 19 pages. DOI=https://dx.doi.org/10.1145/2827872
#' 
#' @source \href{https://files.grouplens.org/datasets/movielens/ml-latest-small.zip}{https://files.grouplens.org/datasets/movielens/ml-latest-small.zip}
#' 
#' @examples
#' head(movielens)
"movielens"
