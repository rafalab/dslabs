#' Puerto Rico daily mortality
#' 
#' A data frame with Puerto Rico daily mortality counts 2015 to May 2018.
#' This includes the day hurricanes Maria made 2017-09-20. 
#' 
#' \itemize{
#' \item date. Date of the count.
#' \item deaths. Number of deaths reported that day.
#' }
#' 
#' @format An object of class \code{data.frame}.
#'  
#' @source Puerto Rico Demographic Registry. Data was extracted from PDF provided in `system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package = "dslabs")`
#' 
#' @usage pr_death_counts
#' 
#' @docType data
#'
#' @keywords datasets
#'
#' @examples 
#' 
#' with(pr_death_counts, plot(date, deaths))
#' 
"pr_death_counts"
