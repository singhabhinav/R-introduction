my_data = read.table("linear_regression/wages_education.csv", header=TRUE, sep=",")
plot(my_data$Education, my_data$Wages)
cor(my_data$Education, my_data$Wages)
