#' Download and read the mnist dataset
#'
#' This function downloads the mnist training and test data available here http://yann.lecun.com/exdb/mnist/
#'
#'
#' 
#' @param path A character giving the full path of the directory to look for files. It assumes the filenames are the same as the originals. If path is \code{NULL} a download or direct read of the files is attempted.
#' @param  download If \code{TRUE} the files will be downloaded and saved in detsdir.
#' @param destdir A character giving the full path of the directory in which to save the downloaded files. The default is to use a temporary directory.
#' @param url A character giving the URL from which to download files. Currently a copy of the data is available at https://www2.harvardx.harvard.edu/courses/IDS_08_v2_03/, the current default URL.
#' @param keep.files A logical. If \code{TRUE} the downloaded files will be saved in \code{destdir}. If \code{FALSE} the entire directory is erased. This argument is ignored if \code{download} is \code{FALSE}.){

#' }
#'
#' @return A list with two components: train and test. Each of these is a list with two components: images and labels. The images component is a
#' matrix with each column representing one of the 28*28 = 784 pixels. The values are integers between 0 and 255 representing grey scale. 
#' The labels components is a vector representing the digit shown in the image.
#'
#' Note that the data is over 10MB, so the download may take several seconds depending on internet speed. If you plan to load the data more than once
#' we recommend you download the data once and read it from disk in the future. See examples.
#' 
#' 
#' @references Y. LeCun, L. Bottou, Y. Bengio, and P. Haffner. "Gradient-based learning applied to document recognition." Proceedings of the IEEE, 86(11):2278-2324, November 1998.  
#' 
#' @author Samuela Pollack
#' @author Rafael A. Irizarry, \email{rafael_irizarry@dfci.harvard.edu}
#' @examples
#' # this can take several seconds, depending on internet speed.
#' 
#' \dontrun{
#' mnist <- read_mnist()
#' i <- 5
#' image(1:28, 1:28, matrix(mnist$test$images[i,], nrow=28)[ , 28:1], 
#'     col = gray(seq(0, 1, 0.05)), xlab = "", ylab="")
#' ## the labels for this image is: 
#' mnist$test$labels[i]
#' }
#'
#' # You can download and save the data to a directory like this:
#' \dontrun{
#' mnist <- read_mnist(download = TRUE, destdir = "~/Downloads")
#' 
#' # and then, going forward, read from disk 
#' mnist <- read_mnist("~/Downloads")
#' }
#' @export
#' 
#' @importFrom utils download.file
#' 
read_mnist <- function(path = NULL, download = FALSE, destdir = tempdir(), 
                       url = "https://www2.harvardx.harvard.edu/courses/IDS_08_v2_03/", keep.files = TRUE){

  mnist <- list(train=list(images=c(), labels=c()), test=list(images=c(), labels=c()))
  for (ttt in c("train", "t10k"))  {
    
    # Open connection to read image file
    fn <- paste0(ttt,"-images-idx3-ubyte.gz")
    
    if(!is.null(path)){
      conn <- gzcon(file(file.path(path, fn), "rb"))
    } else{
      if(download){
        destfile <- file.path(destdir, fn)
        download.file(paste0(url, fn), destfile)
        conn <- gzcon(file(destfile, "rb"))
      } else{
        conn <- gzcon(url(paste0(url, fn), "rb"))
      }
    }
    
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
    
    if(!is.null(path)){
      conn <- gzcon(file(file.path(path, fn), "rb"))
    } else{
      if(download){
        destfile <- file.path(destdir, fn)
        download.file(paste0(url, fn), destfile)
        conn <- gzcon(file(destfile, "rb"))
      } else{
        conn <- gzcon(url(paste0(url, fn), "rb"))
      }
    }
    
    magic <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")  # magic bytes
    nlb <- readBin(conn, 'integer', n = 1, size = 4, endian = "big")    # number of labels
    
    # Read unsigned bytes
    data <- readBin(conn, 'integer', n = nlb, size = 1, signed = FALSE)
    
    # Store as integer
    mnist[[tt]][["labels"]] <- data
  }
  
  if(download){
    if(keep.files){
      message("Keeping downloaded files in the following diretory: ", destdir)
    } else{
      file.remove(file.path(destdir, 
                            c("train-images-idx3-ubyte.gz", "train-labels-idx1-ubyte.gz", 
                              "t10k-images-idx3-ubyte.gz","t10k-labels-idx1-ubyte.gz")))
    }
  }
  
  close(conn)
  return(mnist)
}

