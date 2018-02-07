library(tm)
library(ggplot2)
library(reshape2)
library(wordcloud)
library(RWeka)

setwd("/Users/abhinav/work/R-introduction/")

path = "./text_mining/dataset/movie_reviews/txt_sentoken/pos"

dir = DirSource(path, encoding = "UTF-8")
corpus = VCorpus(dir)

length(corpus)

corpus[[1]]

corpus.ng = tm_map(corpus,removeWords, stopwords("english"))
corpus.ng = tm_map(corpus.ng,removePunctuation)
corpus.ng = tm_map(corpus.ng,removeNumbers)
corpus.ng

BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tdm <- TermDocumentMatrix(corpus.ng, control = list(tokenize = BigramTokenizer))

freq = sort(rowSums(as.matrix(tdm)),decreasing = TRUE)
freq.df = data.frame(word=names(freq), freq=freq)
head(freq.df, 20)


pal=brewer.pal(8,"Blues")
#pal=pal[-(1:3)]

wordcloud(freq.df$word,freq.df$freq,max.words=100,random.order = F, colors=pal)


TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
tdm.trigram = TermDocumentMatrix(corpus.ng,
                                 control = list(tokenize = TrigramTokenizer))

freq = sort(rowSums(as.matrix(tdm.trigram)),decreasing = TRUE)
freq.df = data.frame(word=names(freq), freq=freq)
head(freq.df, 20)

wordcloud(freq.df$word,freq.df$freq,max.words=100,random.order = F, colors=pal)
