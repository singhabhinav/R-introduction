
Sys.setenv(SPARK_HOME = "/usr/hdp/current/spark2-client")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(appName = "SparkR-LinearRegression")

sparkR.session(master = "yarn-client")

# Read the data

dataset <- read.df("/data/spark/sample_multiclass_classification_data.txt", source="libsvm")

# Split the data into training and test set

df_list <- randomSplit(dataset, c(7, 3), 2)

training <- df_list[[1]]
test <- df_list[[2]]

# Train the Linear Regression model

linear_regression_model <- spark.glm(training, label ~ features, family = "gaussian")

# Model summary

summary(linear_regression_model)


predictions <- predict(linear_regression_model, test)

predictions

head(predictions)

# Question - Apply the simple linear regression model for the 
# data set faithful, and estimate the next eruption duration 
# if the waiting time since the last eruption has been 80 minutes.

dataset <- as.data.frame(faithful)
head(dataset)

dataset <- createDataFrame(dataset)
df_list <- randomSplit(dataset, c(7, 3), 2)

training <- df_list[[1]]
test <- df_list[[2]]

linear_regression_model <- spark.glm(training, eruptions ~ waiting, family = "gaussian")

summary(linear_regression_model)

predictions <- predict(linear_regression_model, test)

newdata = data.frame(waiting=80)
newdata <- createDataFrame(newdata)
head(predict(linear_regression_model, newdata))
