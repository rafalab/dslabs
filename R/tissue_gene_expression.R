#' Gene expression profiles for 189 biological samples taken from seven different tissue types.
#' 
#' This is a subset of the data provided by the \code{tissuesGeneExpression}
#' package available from the \code{genomicsclass} GitHub repository. 

#' The predictors are gene expression measurements from 500 genes that
#' are a random subset of the original 22,215. 
#' 
#' The example dataset is recommended for illustrating
#' clustering and machine learning techniques.
#'
#'
#' \itemize{
#' \item x. The predictors composed of 500 genes. Each row is a gene expression profile and each column is different gene. The column names are the gene symbols.
#' \item y. The outcomes. A character vector representing the tissue. One of seven tissue types.
#' }
#' 
#
#' @docType data
#'
#' @usage tissue_gene_expression
#'
#' @format An object of class \code{list}.
#'  
#' @keywords datasets
#'
#'
#' @source \href{https://github.com/genomicsclass/tissuesGeneExpression}{https://github.com/genomicsclass/tissuesGeneExpression}
#' 
#'
#' @examples
#' table(tissue_gene_expression$y)
#' dim(tissue_gene_expression$x)
"tissue_gene_expression"
