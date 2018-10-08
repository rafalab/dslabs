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
ind <- which(!is.na(map))

set.seed(347)
e <- e[sample(ind, 500), ]

tissue_gene_expression <- list(x = t(e), y = factor(tissue))

save(tissue_gene_expression, 
     file="data/tissue_gene_expression.rda",
     compress = "xz")

### test
if(FALSE){
  library(caret)
  ind <- which(colMeans(tissue_gene_expression$x) > 0.5)
  fit <- train(tissue_gene_expression$x[,ind],
               tissue_gene_expression$y, method = "knn",
               tuneGrid = data.frame(k=seq(1,7,2)))
  plot(fit)
}