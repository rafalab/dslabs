#' Mice weights 
#' 
#' Weights for mice under two diets: chow and high fat. Data provided by Karen Svenson from Jackson Laboratories. Funding to generate these data came from NIH grant P50 GM070683 awarded to Gary Churchill.
#'
#' \itemize{
#'   \item sex. The sex of the mice.
#'   \item diet. The diet of the mice: chow or high fat.
#'   \item body_weight. Body weight in grams at 12 weeks.
#' }
#' 
#' @docType data
#'
#' @usage mice_weights
#'
#' @format An object of class \code{"data.frame"}. 
#'
#' @keywords datasets
#'
#' @source Karen Svenson from Jackson Laboratories
#' 
#' @examples
#' mice_weights |> head()
#' with(mice_weights, table(sex, diet))
#' 
"mice_weights"
