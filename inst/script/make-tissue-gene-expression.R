#devtools::install_github("genomicsclass/tissuesGeneExpression")
##rafalib::install_bioc("hgu133plus2.db")
library(hgu133plus2.db)
library(tissuesGeneExpression)

data(tissuesGeneExpression)

map <- mapIds(hgu133plus2.db, 
              keytype="PROBEID", 
              column="SYMBOL",
              keys=rownames(e),
              mutliVals = first)

o <- order(tissue)
tissue <- tissue[o]
e <- e[,o]
rownames(e) <- map
colnames(e) <- paste(tissue, 
                     unlist(
                       sapply(table(tissue), function(n) 1:n)), 
                     sep="_")
## pick featuers with a gene name and make sure they are unique
ind <- which(!is.na(map) & !duplicated(map))

set.seed(1994)
e <- e[sample(ind, 500), ]

tissue_gene_expression <- list(x = t(e), y = factor(tissue))

save(tissue_gene_expression, 
     file="data/tissue_gene_expression.rda",
     compress = "xz")

### test
if(FALSE){
  library(caret)
  ind <- which(matrixStats::colSds(tissue_gene_expression$x) > 0.5)
  tissue_gene_expression$x <- with(tissue_gene_expression,
                                   sweep(x, 1, rowMeans(x)))
  fit <- train(tissue_gene_expression$x[,ind],
               tissue_gene_expression$y, method = "knn",
               tuneGrid = data.frame(k=seq(1,7,2)))
  plot(fit)
}