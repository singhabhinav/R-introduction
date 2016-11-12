my_data = read.table("linear_regression/wages_education.csv", header=TRUE, sep=",")
plot(my_data$Wages, my_data$Education)
cor(my_data$Wages, my_data$Education)
