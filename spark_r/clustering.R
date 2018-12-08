
Sys.setenv(SPARK_HOME = "/usr/hdp/current/spark2-client")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(appName = "SparkR-ML-kmeans-example")

sc <- sparkR.session(master = "yarn-client")

sc <- sparkR.session(master = "yarn-client")

t <- as.data.frame(Titanic)
training <- createDataFrame(t)
df_list <- randomSplit(training, c(7,3), 2)
kmeansDF <- df_list[[1]]
kmeansTestDF <- df_list[[2]]
length(t)

head(t)


kmeansModel <- spark.kmeans(kmeansDF, ~ Class + Sex + Age + Freq, k = 3)

summary(kmeansModel)

head(fitted(kmeansModel))

kmeansPredictions <- predict(kmeansModel, kmeansTestDF)

head(kmeansPredictions)
