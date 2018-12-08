Sys.setenv(SPARK_HOME = "/usr/hdp/current/spark2-client")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(appName = "SparkR-Recommendation")

sc <- sparkR.session(master = "yarn-client")

#customSchema <- structType(
 #   structField("userId", "integer"),
  #  structField("movieId", "integer"),
   # structField("rating", "double"),
    #    structField("timestamp", "integer"),

#)

#csvPath = "/data/ml-20m/ratings.csv"
#df <- read.df(csvPath, "csv", header = "false", inferschema="true", schema = customSchema, na.strings = "NA")
#df <- read.df(csvPath, "csv", header = "true", inferschema="true", na.strings = "NA")

#printSchema(df)
#createOrReplaceTempView(test, "test")
#teenagers <- sql("SELECT count(*) from test")
#head(teenagers)


customSchema <- structType(
   structField("userId", "integer"),
   structField("movieId", "integer"),
   structField("rating", "double"))
csvPath = "/data/ml-1m/user_ratings.csv"
df <- read.df(csvPath, "csv", header = "false", schema = customSchema, na.strings = "NA")
printSchema(df)


training <- df
test <- df
model <- spark.als(training, maxIter = 5, regParam = 0.01, userCol = "userId",
                   itemCol = "movieId", ratingCol = "rating")


#createOrReplaceTempView(training, "training")

#teenagers <- sql("SELECT count(*) from training")
#head(teenagers)


summary(model)

predictions <- predict(model, test)

head(predictions)
