# Applied

setwd("../Chapt2")

# Exercise 8
# a & b
college = read.csv("../DataSets/College.csv")
#fix(college)
rownames(college) = college[,1] #this creates row.names. R will not perform calculations on this row
#fix(college)
college = college[,-1] #deleting the 1st column where the names are stored
#fix(college)

# c
# generate a numerical summary of the variables in the dataset
print (summary(college))

# generate scatterplot matrix of the frist 10 columns or variables of the data
pairs(college[,1:10])

# generate boxplots of Outstate versus Private
Private = as.factor(college$Private) # treating variable as qualitative
#print(Private)
plot(Private, college$Outstate, xlab = 'Private indicator', ylab = 'Out-of-state tuition')

# create qualitative variable called Elite by binning the Top10perc variable
# universities will be divided into two groups based on whether or not the proportion of students coming from the top 10% of their high school classes exceeds 50%
Elite = rep('No', nrow(college)) # this will print 'No' 777 times (777 = number of rows of the college data)
Elite[college$Top10perc>50] = 'Yes' #if top 10% exceeds 50% of students, print yes
Elite = as.factor(Elite)
college = data.frame(college, Elite)
#fix (college)
print(summary(college))

# generate boxplots of Outstate versus Elite
plot(Elite, college$Outstate, xlab = 'Elite institution', ylab = 'Out-of-state tuition')

# generate some histograms with differeing number of bins for a few quantitative variables
par(mfrow = c(3,3)) # matrix print window: 3 lines and 2 columns
hist(college$Room.Board, breaks = 20, main = 'Histogram of Room and Board Costs', xlab = 'Costs', xlim = c(1500, 9000), )
hist(college$Room.Board, breaks = 20, main = 'Density of Room and Board Costs', xlab = 'Costs', xlim = c(1500, 9000),freq=FALSE)
curve(dnorm(x, mean=mean(college$Room.Board), sd=sd(college$Room.Board)), add=TRUE, col='blue', lwd=2)
hist(college$Room.Board, 30, main = 'Histogram of Room and Board Costs', xlab = 'Costs', xlim = c(1500, 9000))
box()
#histinfo <- hist(college$Room.Board)
#print (histinfo)
hist(college$Books, breaks = 15, main = 'Histogram of Estimated Book Costs', xlab = 'Costs', xlim=c(90,2500) )
hist(college$Books, breaks = 15, main = 'Density of Estimated Book Costs', xlab = 'Costs', freq=FALSE, xlim=c(90,2500))
curve(dnorm(x, mean=mean(college$Books), sd=sd(college$Books)), add=TRUE, col='blue', lwd=2)
hist(college$Books, 30, main = 'Histogram of Estimated Book Costs', xlab = 'Costs', xlim=c(90,2500))
box()

hist(college$Personal, breaks = 15, main = 'Histogram of Estimated Personal Spending', xlab = 'Costs', xlim=c(250,7000) )
hist(college$Books, breaks = 15, main = 'Density of Estimated Personal Spending', xlab = 'Costs', freq=FALSE, xlim=c(250,7000))
curve(dnorm(x, mean=mean(college$Books), sd=sd(college$Books)), add=TRUE, col='blue', lwd=2)
hist(college$Books, 30, main = 'Histogram of Estimated Personal Spending', xlab = 'Costs', xlim=c(250,7000))
box()

# Continue exploring the data
plot(college$Accept, college$Enroll)
# not all students accepted enrolled

plot(college$Elite, college$Outstate)
# most elite students pay higher tuition fees than non-elite 

par(mfrow = c(1,2))
plot(college$Top10perc, college$Grad.Rate)
plot(college$Top25perc, college$Grad.Rate)
# Colleges with most students from the top 10% does not necessarily have the higher graduate rates. 
# graduate rate above 100% is impossible

par(mfrow = c(1,2))
plot(college$Outstate, college$F.Undergrad, ylim = c(0,35000))
plot(college$Outstate, college$P.Undergrad, ylim = c(0,35000))
# most of the students do not pay the highest tuition fee. However, there are more full-time undergraduates paying for higher tuition fee than part-time

par(mfrow = c(1,1))
plot(college$Personal, college$Expend)
# the higher the institutional expenditure per student, the lower the estimated personal spending 
plot(college$Room.Board, college$Expend)
# however, the higher the institutional spending per student. the higher the room and board costs

# Exercise 9
Auto = read.table("../DataSets/Auto.data", header=T, na.strings="?")
Auto = na.omit(Auto)
#fix(Auto)

# a
summary(Auto)
# quantitative: mpg, displacement, horsepower, weight, acceperation, cylinders (can be treated as qualitative), year(can be treated as qualitative)
# qualitative: name, origin

# b
# sapply will return a list
sapply(Auto[,1:7], range) # or summary(Auto)

# c
sapply(Auto[,1:7], mean) # or summary(Auto)

sapply(Auto[,1:7], sd)

# d
# remove 10th through 85th observations. range, mean, std of remaining subset
Auto_subset = Auto[-c(10:85),]
sapply(Auto_subset[,1:7], range)
sapply(Auto_subset[,1:7], mean)
sapply(Auto_subset[,1:7], sd)

# e
# investigate predictors graphically
pairs(Auto)
cylinders = as.factor(Auto$cylinders)
plot(cylinders, Auto$acceleration)
# more cylinders does not mean more acceleration
plot(cylinders, Auto$horsepower)
# more cylinders means more horsepower
plot(Auto$acceleration, Auto$horsepower)
# more horsepower does not mean more acceleration
plot(Auto$mpg, Auto$year)
# car more efficient as years pass by (mpg = miles per gallon)
plot(Auto$mpg, Auto$weight)
# lighter the car, more miles per gallon
plot(Auto$mpg, Auto$cylinders)
# more cylinders, less mpg

# f
# predicting mgp
pairs(Auto)
# more cylinders = less mpg
# more displacement, horsepower and weight = less mpg
# more acceleration = more mpg