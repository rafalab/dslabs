# import Wisconsin Diagnostic Breast Cancer Dataset from UCI Machine Learning Repository
# citation: W.N. Street et al., 1993

library(tidyverse)

# import data
url <- "http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
brca_nuclei <- read.csv(url, header = FALSE)

# add variable names - info from wdbc.names file at UCI ML repository
x <- c("radius", "texture", "perimeter", "area", "smoothness", "compactness", "concavity", "concave_pts", "symmetry", "fractal_dim")
y <- c("mean", "se", "worst")
temp <- expand.grid(x = x, y = y)    # build variable names as all combos of x,y
names(brca_nuclei) <- c("id", "type", paste(temp$x, temp$y, sep = "_"))

# arrange by type to group like samples together
brca_nuclei <- brca_nuclei %>% arrange(type)

# extract numeric features
features <- brca_nuclei %>% select(-id, -type) %>% as.matrix()

# extract tumor type
type <- brca_nuclei$type

# combine features and type into brca object
brca <- list(x = features, y = type)

save(brca, file = "data/brca.rda", compress = "xz")
