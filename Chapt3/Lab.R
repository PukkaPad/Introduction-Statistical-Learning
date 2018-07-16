# Lab: Linear Regression
work_dir <- "/Users/MarianaSouza/Code/books/ISL/projects/stats-learning/Chapt3"
setwd(work_dir)

# Load MASS package
library(MASS)
# Load ISLR package
library(ISLR)

# Simple linear regression
# Predict medv (median house value) using 13 predictors, such as rm (average n of rooms per house), age (average age of houses) and lstat (% of households wit low socioeconomic status)
fix (Boston)
names(Boston)
?Boston
#lm(y~x, data)
lm.fit = lm(medv~lstat, data=Boston)
attach(Boston)
lm.fit = lm(medv~lstat)
lm.fit
#lm.fit gives us the coefficients. 
summary(lm.fit)
# summary will provide us more detailed information
# use names() funtion to find out what other pieces are stored in lm.fit
names(lm.fit)
coef(lm.fit)
# to get the confidence interval for the coefficient estimates:
confint(lm.fit)
# to produce confidence intervals and prediction intervals for the prediction medev for a given value lstat
predict(lm.fit, data.frame(lstat=c(5,10,15)), interval = "confidence")
#for lstat = 10, 95% confidence interval is (24.47414 25.63256)
predict(lm.fit, data.frame(lstat=c(5,10,15)), interval = "prediction")
#for lstat = 10, 95% prediction interval is (12.827626 37.27907)
#predicted value for mdev is 25.05335
# plot mdev and lstat along with least square regression line
plot(lstat, medv, pch = 20)
abline(lm.fit, lwd=3, col='red')
#plot(1:20, 1:20, pch = 1:20)
# Generate 4 diagnostic plots
par(mfrow=c(2,2))
plot(lm.fit)
# It's also possible to generate residuals from linear regression 'residuals()' and studentized residuals 'rstudent()'
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
# remember, if the points ina residual plot are randomly dispersed around the x axis, a linear regression model is appropriate for the data; otherwise, a non-linear model is more appropriate.
# the residual plots showed some evidence of non-linearity
# To measure how far away the independent variable of an observation are from those of the other observations, leverage statistics is used
# in R it is computed using 'hatvalues()' function
# The rule of thumb is to examine any observations 2-3 times greater than the average hat value.
plot(hatvalues(lm.fit))
# to find out which obs has the largest leverage statistics:
which.max(hatvalues(lm.fit))

## Multiple Linear Regression
#lm(y~x1+x2+x3)
lm.fit=lm(medv~lstat+age, data=Boston)
#output regression coefficients
summary(lm.fit)
# to do the multiple linear regression using all predictors
lm.fit=lm(medv~., data = Boston)
summary(lm.fit)
# to access individual components of the summary
