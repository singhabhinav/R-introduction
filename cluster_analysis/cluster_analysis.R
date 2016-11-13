# find distance matrix

d <- dist(as.matrix(mtcars))

# apply hirarchical clustering

hc <- hclust(d)

# plot

plot(hc)
