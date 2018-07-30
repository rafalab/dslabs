## download data (takes a few minutes)
library(tidyverse)
url <- "http://files.grouplens.org/datasets/movielens/ml-latest-small.zip"
td <- tempdir()
print(td)
tf <- tempfile(tmpdir=td, fileext=".zip")
download.file(url, tf)

# to see files:
#unzip(tf, list = TRUE)

## read the data
movielens <- read_csv(unz(tf, "ml-latest-small/ratings.csv"))
movielens_titles <- read_csv(unz(tf, "ml-latest-small/movies.csv"))

## separate year from title and keep only recent movies
movielens_titles <- movielens_titles %>% 
  extract(title, c("title", "year"), regex = "(.*)\\s\\((\\d+)\\)", convert = TRUE) 

movielens <- right_join(movielens_titles, movielens, by = "movieId")

movielens <- as.data.frame(movielens)
movielens$genres <- factor(movielens$genres)
## check
#movielens  %>% group_by(movieId) %>% summarize(avg = mean(rating), n=n(), title= title[1]) %>% arrange(desc(avg))
#movielens %>%  group_by(movieId) %>% summarize(avg = mean(rating), n=n(), title= title[1]) %>% filter(n>100) %>% arrange(desc(avg))
#movielens %>%  group_by(movieId) %>% summarize(avg = mean(rating), n=n(), title= title[1]) %>% filter(n>10) %>% arrange(avg)

save(movielens, file = "data/movielens.rda", compress="xz")

unlink(td, recursive = TRUE, force=TRUE)




