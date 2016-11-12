my_data = read.table("linear_regression/wages_education.csv", header=TRUE, sep=",")
attach(my_data)

fit <- lm(Wages ~ Education)

#Find more about fit
attributes(fit)
summary(fit)

#predict

new_data = data.frame(Education=14)

predict(fit, new_data)

plot(Education, Wages)
abline(fit)
