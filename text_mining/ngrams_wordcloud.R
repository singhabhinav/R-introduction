# Install libraries

library(tm)
library(ggplot2)
library(reshape2)
library(wordcloud)
library(RWeka)

# Set working directory

setwd("/Users/abhinav/work/R-introduction/")

# Access only positive reviews

path = "./text_mining/dataset/movie_reviews/txt_sentoken/pos"

# Load corpus from local files

dir = DirSource(path, encoding = "UTF-8")
corpus = VCorpus(dir)

# Check how many documents have been loaded.

length(corpus)

# Access the document in the first entry

corpus[[1]]

# Apply transformations to the original corpus

corpus.ng = tm_map(corpus,removeWords, stopwords("english"))
corpus.ng = tm_map(corpus.ng,removePunctuation)
corpus.ng = tm_map(corpus.ng,removeNumbers)
corpus.ng

# Use Weka???s n-gram tokenizer to create a TDM
# that uses as terms the bigrams that appear in the corpus

BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tdm <- TermDocumentMatrix(corpus.ng, control = list(tokenize = BigramTokenizer))

# Extract the frequency of each bigram and analyse the twenty most frequent ones

freq = sort(rowSums(as.matrix(tdm)),decreasing = TRUE)
freq.df = data.frame(word=names(freq), freq=freq)
head(freq.df, 20)

# Blue colors for the wordcloud
pal=brewer.pal(8,"Blues")

# Plot the wordcloud
wordcloud(freq.df$word,freq.df$freq,max.words=100,random.order = F, colors=pal)

# Plot trigram wordcloud
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
tdm.trigram = TermDocumentMatrix(corpus.ng,
                                 control = list(tokenize = TrigramTokenizer))

freq = sort(rowSums(as.matrix(tdm.trigram)),decreasing = TRUE)
freq.df = data.frame(word=names(freq), freq=freq)
head(freq.df, 20)

wordcloud(freq.df$word,freq.df$freq,max.words=100,random.order = F, colors=pal)
