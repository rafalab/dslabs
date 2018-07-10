source("R/read_mnist.R")
library(caret)

## read-in data
mnist <- read_mnist()
## keep only 2s and 7s
index_27 <- which(mnist$train$labels %in% c(2,7))
y <- mnist$train$labels[index_27] 
x <- mnist$train$images[index_27,]

## we start by creating the "true" conditional expectation
row_column <- expand.grid(row=1:28, col=1:28) #temporary object to help figure out the quandrants
upper_left_ind <- which(row_column$col <= 14 & row_column$row <= 14)
lower_right_ind <- which(row_column$col > 14 & row_column$row > 14)
x <- x > 200 #binarize the values. Above 200 is ink, below is no ink
x <- cbind(rowSums(x[ ,upper_left_ind])/rowSums(x), #proportion of pixels in upper right quandrant
           rowSums(x[ ,lower_right_ind])/rowSums(x)) #proportion of pixes in lower rigth quandrant

## To estimate the "true" p(x_1, x_2) we will smooth the result of knn 
fit <-knn3(x, factor(y), 51)
GS <- 150
true_p <- expand.grid(x_1 = seq(min(x[,1]), max(x[,1]), len=GS),
                      x_2 = seq(min(x[,2]), max(x[,2]), len=GS))
                        
y_hat <- predict(fit, newdata = true_p, type="prob")
true_p$p <- pmax(loess(y_hat[,2]~ x_1 * x_2, data= true_p, degree=1, span=1/5)$fitted, 0)

## now we create the example dataset
## it includes the labels, the two predictors, and an index so we can recuperate the image from original mnist data
set.seed(1971)
ind <- sample.int(length(index_27), 1000)
labels <- y[ind]
x <- x[ind, ]
index_train <- createDataPartition(labels, p=0.8, list = FALSE)

mnist_27 <- list(
  train = data.frame(y = factor(labels[index_train]),
                     x_1 = x[index_train,1],
                     x_2 = x[index_train,2]),
  test = data.frame(y = factor(labels[-index_train]),
                     x_1 = x[-index_train,1],
                     x_2 = x[-index_train,2]),
  index_train = index_27[ind][index_train],
  index_test = index_27[ind][-index_train],
  true_p = true_p)

save(mnist_27, file = "data/mnist_27.rda", compress="xz")

# check
#ggplot2::ggplot(mnist_27$true_p, aes(x_1, x_2, fill = p)) + geom_raster()+ scale_fill_gradientn(colors=c("#00BFC4","white","#F8766D"))





       