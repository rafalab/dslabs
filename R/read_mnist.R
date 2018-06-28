#' Download and read the mnist dataset
#'
#' This function downloads the mnist training and test data from http://yann.lecun.com/exdb/mnist/
#'
#'  
#' @return A list with two components: train and test. Each of these is a list with two components: images and labels. The images component is a
#' matrix with each column representing one of the 28*28 = 784 pixels. The values are integers between 0 and 255 representing grey scale. 
#' The labels components is vector representing the digit shown in the image.
#'
#' Note that the data being downloaded is over 200MB, so it make take several seconds depending on internet speed.
#' 
#' @source http://yann.lecun.com/exdb/mnist/
#' 
#' @references Y. LeCun, L. Bottou, Y. Bengio, and P. Haffner. "Gradient-based learning applied to document recognition." Proceedings of the IEEE, 86(11):2278-2324, November 1998.  
#' 
#' @examples
#' # this can take several seconds, depending on internet speed.
#' mnist <- read_mnist()
#' i <- 5
#' image(1:28, 1:28, matrix(mnist$test$images[i,], nrow=28)[ , 28:1], 
#'     col = gray(seq(0, 1, 0.05)), xlab = "", ylab="")
#' ## the labels for this image is: 
#' mnist$test$labels[i]
#'
#' @export
#' 

read_mnist <- function(){
  mnist <- list(train=list(images=c(), labels=c()), test=list(images=c(), labels=c()))
  for (ttt in c("train", "t10k"))  {
    
    # Open connection to read image file
    fn <- paste0(ttt,"-images-idx3-ubyte.gz")
    url <- url(paste0("http://yann.lecun.com/exdb/mnist/",fn), "rb")
    conn <- gzcon(url)
    
    magic <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")  # magic bytes
    typ <- bitwAnd(bitwShiftR(magic,8), 0x000000ff)   # should be 8 => unsigned byte    
    ndm <- bitwAnd(magic, 0x000000ff)                 # dimensionality (should be 3)
    
    # Read dimensions
    dim <- readBin(conn, 'integer', n = ndm, size = 4, endian = "big")
    
    # Read unsigned bytes
    data <- readBin(conn, 'integer', n = prod(dim), size = 1, signed = FALSE)
    
    # store "t10k" data to "test" list
    tt <- ttt
    if(tt == "t10k")
      tt <- "test"
    
    # Save as matrix, row is image number, col is the image as 
    # single-dimensional 28 x 28 array of real.
    mmm <- matrix(data, nrow=dim[1], byrow = TRUE) 
    mnist[[tt]][["images"]] <- mmm
    close(conn)
    
    # Open connection to read label file  
    fn <- paste0(ttt,"-labels-idx1-ubyte.gz")
    url <- url(paste0("http://yann.lecun.com/exdb/mnist/",fn), "rb")
    conn <- gzcon(url)
    
    magic <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")  # magic bytes
    nlb <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")    # number of labels
    
    # Read unsigned bytes
    data <- readBin(conn, 'integer', n = nlb, size = 1, signed = FALSE)
    
    # Store as integer
    mnist[[tt]][["labels"]] <- data
    close(conn)
  }
  mnist
}
