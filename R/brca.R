#' Breast Cancer Wisconsin Diagnostic Dataset from UCI Machine Learning Repository
#' 
#' Biopsy features for classification of 569 malignant (cancer) and benign (not cancer) breast masses.
#' 
#' Features were computationally extracted from digital images of fine needle aspirate
#' biopsy slides. Features correspond to properties of cell nuclei, such as size, shape and regularity.
#' The mean, standard error, and worst value of each of 10 nuclear parameters is reported for a total of 30 features.
#' 
#' This is a classic dataset for training and benchmarking machine learning algorithms.
#'
#'
#' \itemize{
#' \item y. The outcomes. A factor with two levels denoting whether a mass is malignant ("M") or benign ("B").
#' \item x. The predictors. A matrix with the mean, standard error and worst value of each of 10 nuclear measurements on the slide, for 30 total features per biopsy:
#'     \itemize{
#'       \item radius. Nucleus radius (mean of distances from center to points on perimeter).
#'       \item texture. Nucleus texture (standard deviation of grayscale values).
#'       \item perimeter. Nucleus perimeter.
#'       \item area. Nucleus area.
#'       \item smoothness. Nucleus smoothness (local variation in radius lengths).
#'       \item compactness. Nucleus compactness (perimeter^2/area - 1).
#'       \item concavity, Nucleus concavity (severity of concave portions of the contour).
#'       \item concave_pts. Number of concave portions of the nucleus contour.
#'       \item symmetry. Nucleus symmetry.
#'       \item fractal_dim. Nucleus fractal dimension ("coastline approximation" -1).
#'     }
#' }
#' 
#
#' @docType data
#'
#' @usage brca
#'
#' @format An object of class \code{list}.
#'  
#' @keywords datasets
#'
#'
#' @source \href{https://archive.ics.uci.edu/ml/datasets/}{UCI Machine Learning Repository}
#' 
#'
#' @examples
#' table(brca$y)
#' dim(brca$x)
#' head(brca$x)
"brca"
