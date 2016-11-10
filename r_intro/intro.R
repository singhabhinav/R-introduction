# P1

# An addition
5 + 5

# A subtraction
5 - 5

# A multiplication
3 * 5

# A division
(5 + 5) / 2

# Exponentiation

2^5

# Modulo

28 %% 6

#P2

# Assign the value 42 to x
x <- 42

# Print out the value of the variable x
x

#P3 Variable assignment (2)

# Assign the value 5 to the variable my_apples

my_apples <- 5


# Print out the value of the variable my_apples

my_apples

#P4 Variable assignment (3)

# Assign a value to the variables my_apples and my_oranges
my_apples <- 5
my_oranges <- 6

# Add these two variables together
my_apples + my_oranges

# Create the variable my_fruit
my_fruit <- my_apples + my_oranges

# Basic data types in R

# Decimals values like 4.5 are called numerics.
# Natural numbers like 4 are called integers. Integers are also numerics.
# Boolean values (TRUE or FALSE) are called logical.
# Text (or string) values are called characters.

# What's that data type?

my_numeric <- 42
my_character <- "universe"
my_logical <- FALSE
class(my_numeric)
class(my_character)
class(my_logical)

# Create a vector

# Vectors are one-dimension arrays that can hold numeric data, character data, or logical data.
# In other words, a vector is a simple tool to store data.
# For example, you can store your daily gains and losses in the casinos.

numeric_vector <- c(1, 2, 3)
character_vector <- c("a", "b", "c")


# P2- Assign values to variables and do computation

x<-9
y<- 16

x+y
x-y
sqrt(x)
sqrt(y)
sqrt(x)+sqrt(y)

# P3- Create a vector using 'concatenate' or 'combine' function

z <- c(1,2,3,5,9,10)
z
z*2+150

# P4- Vector "Recyling"

c(1,2,3,4) + c(0,10)

# P5- Get working directory and set working directory
getwd()
setwd("/home/abhinav/R-introduction/r_intro")

# P6- list all objects in the workspace
ls()

# P7- list all files in the working directory
list.files()

# P8- Getting help on any function
?list.files()

#P9- Sequencing
1:15
15:0
pi:20
seq(0,20,0.5)
seq(1,20, length=40)
rep(c(1,2,3), times=25)
rep(c(1,2,3), each=25)

#P10- Reading data

cars <- read.csv("cars.csv")
View(cars)

# P11- Subsetting dataframe

newcars1 <- cars[1:10,1:3]
newcars2 <- cars[1:10, c(1,8,9)]
newcars3 <- cars[1:10, c("Origin", "Year")]

# P12 - Find rows with max, min etc.

newcars4<- cars[which.max(cars$MPG),]
newcars5<- cars[cars$MPG == max(cars$MPG),]
newcars6<- cars[which.min(cars$MPG),]
newcars7<- cars[cars$MPG == min(cars$MPG),]

# P13- Creating New Variables in the dataset
cars$MPGpCYL <- cars$MPG/cars$Cylinders
cars$Mileage <- ifelse(cars$MPG >= 30, "Good", "Not so Good")

# P14- Summarizing data
head(cars)
tail(cars)
str(cars)
dim(cars)
str(cars)
names(cars)
ncol(cars)
nrow(cars)
class(cars)

# P15- Descriptive Stats
attach(cars)
mean(MPG)
median(MPG)
mode(MPG)
var(MPG)
sd(MPG)
range(MPG)
min(MPG)
max(MPG)
quantile(MPG, seq(0,1,0.05))

# Count of cars by Origin
library(plyr) # install.packages("plyr")
count(cars, 'Origin')

# Write the output to Excel (csv) file.
write.csv(count(cars, 'Origin'), "countsheet.csv")

# Means, max, min by Origin

aggregate(MPG, list(Origin), mean)
aggregate(MPG, list(Origin), max)
aggregate(MPG, list(Origin), min)

# P16- plots

library(ggplot2) # may need to install this package using install.packages()
library(gridExtra)

p <- ggplot(cars, aes(Origin, MPG))

p + geom_boxplot(aes(fill = Origin))

p1 <- ggplot(cars, aes(x=Horsepower, y= Weight))
p1+geom_point(aes(color=factor(Origin))) + scale_color_manual(values = c("Green", "Purple", "Orange"))
