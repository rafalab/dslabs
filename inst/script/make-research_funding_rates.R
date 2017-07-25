library("pdftools")
temp_file <- tempfile()
download.file("http://www.pnas.org/content/suppl/2015/09/16/1510159112.DCSupplemental/pnas.201510159SI.pdf",
              temp_file)


txt <- pdf_text(temp_file)
tab <- txt[2]
tab <- strsplit(tab,"\n")[[1]]
the_names <- tab[[3]]
tab <- tab[4:14]
tab <- strsplit(tab,"\\s\\s+")
tab <-t(sapply(tab, function(x) x))
tab <- tab[,-1]
tab

the_names <- strsplit(gsub(",\ n|,\ %","",the_names),"\\s\\s+")[[1]][-1]
the_names <- paste(rep(the_names,each=3),tab[1,-1])
the_names <- gsub(" ","_",the_names)
the_names <- c(tab[1,1], the_names)
colnames(tab) <- tolower(the_names)
tab <- tab[-1,]
tab <- as.data.frame(tab, stringsAsFactors = FALSE)
my_as_numeric <- function(x) as.numeric(gsub(",|a|b","",x))
tab[,-1] <- apply(tab[,-1], 2, my_as_numeric)
tab <- tab[-1,] ##take out total since we can compute
tab

research_funding_rates <- tab
save(research_funding_rates, file="data/research_funding_rates.rda", compress="xz")
