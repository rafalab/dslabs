#' Mice weights 
#' 
#' Body weights, bone density, and percent fat for mice under two diets: chow and high fat. Data provided by Karen Svenson from Jackson Laboratories. Funding to generate these data came from NIH grant P50 GM070683 awarded to Gary Churchill.
#'
#' \itemize{
#'   \item body_weight. Body weight in grams at 19 weeks.
#'   \item bone_density. Body density.
#'   \item percent_fat. Percent fat.
#'   \item sex. The sex of the mice.
#'   \item diet. The diet of the mice: chow or high fat.
#'   \item gen. These are outbread mice. This variable denotes the generation.
#'   \item litter. Which of two litters mice belong to.
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
#' @source Karen Svenson, Daniel M. Gatti, and Gary Churchill from Jackson Laboratories. 
#' 
#' @references Daniel M. Gatti, Petr Simecek, Lisa Somes, Clifton T. Jeffrey, Matthew J. Vincent, Kwangbom Choi, Xingyao Chen, Gary A. Churchill, and Karen L. Svenson. "The Effects of Sex and Diet on Physiology and Liver Gene Expression in Diversity Outbred Mice". bioRxiv 098657; \doi{10.1101/098657}
#'
#' @examples
#' mice_weights |> head()
#' with(mice_weights, table(sex, diet))
"mice_weights"
