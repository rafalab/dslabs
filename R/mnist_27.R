#' Useful example for illustrating machine learning algorithms based on MNIST data
#' 
#' We only include a randomly selected set of 2s and 7s along with the two predictors based on the 
#' proportion of dark pixels in the upper left and lower right quadrants respectively. The dataset is divided into 
#' training and test sets.
#'  
#'
#' \itemize{
#' \item train. A data frame containing  training data: labels and predictors.
#' \item test. A data frame containing  test data: labels and predictors.
#' \item index_train. The index of the original mnist training data used for the training set.
#' \item index_test. The index of the original mnist test data used for the test set.
#' \item true_p. A \code{data.frame} containing the 
#' two predictors \code{x_1} and \code{x_2} and the conditional probability of being a 7 
#' for \code{x_1}, \code{x_2}.
#' }
#' 
#' @seealso [read_mnist()]
#' 
#' @docType data
#'
#' @usage mnist_27
#'
#' @format An object of class \code{list}.
#'  
#' @keywords datasets
#'
#' @references Y. LeCun, L. Bottou, Y. Bengio, and P. Haffner. "Gradient-based learning applied to document recognition." Proceedings of the IEEE, 86(11):2278-2324, November 1998.  
#'
#'
#' @examples
#' with(mnist_27$train, plot(x_1, x_2, col = as.numeric(y)))
#' 
"mnist_27"
