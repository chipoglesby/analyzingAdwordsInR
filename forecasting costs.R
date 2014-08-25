library(ggplot2)
library(RAdwords)
library(dplyr)
library(forecast)
library(reshape)


getAuth()
loadToken()
refreshToken()

#Metrics for Account Performance Report
body <- statement(select=c('Date','Cost','ConversionValue', 'AverageCpc'), 
                  report="ACCOUNT_PERFORMANCE_REPORT",
                  start="20120101", 
                  end="20140730")
data <- getData(clientCustomerId='xx-xxx-xxx',statement=body,transformation=TRUE) #JMJ SUPPLY

# Create a time-series object in R with starting year 2007 and frequency 12, for months.
# You can replace months and year with your own time. 
myts<- ts(data$Cost, start=c(2012, 7), end=c(2014, 12), frequency= 365)

# Create a HoltWinters model for the time-series object “myts”.
HWmodel<- HoltWinters(myts)

# This function predicts the number of expected visitor for the next twelve months
# (n.ahead=12) with 95% of confidence interval.
future<- predict(HWmodel, n.ahead=30, level=0.95)

# Plot the observed as well as the fitted data on Y-axis with X-axis as time.
plot(HWmodel, future)

#Now for some seasonal stuff: http://goo.gl/mvCLxw

# Seasonal decompostion
fit <- stl(myts, s.window="period")
plot(fit) # additional plots
monthplot(myts)
seasonplot(myts)

#Exponential Models

# simple exponential - models level
fit <- HoltWinters(myts, beta=FALSE, gamma=FALSE)
accuracy(fit)

# double exponential - models level and trend
fit <- HoltWinters(myts, gamma=FALSE)
accuracy(fit)

# triple exponential - models level, trend, and seasonal components
fit <- HoltWinters(myts)
accuracy(fit)

# predict next 12 future values

#What to do next. Taken from: http://goo.gl/MRp2q3

#Preview what the plot will look like if you want
HWplot(myts, n.ahead=365, CI=.95, error.ribbon='green',line.size=1)

#make adjustments to the graph
graph <- HWplot(myts, n.ahead = 365, error.ribbon = "red")

# add a title
graph <- graph + opts(title = "Forecast for PPC Costs")

# change the x scale a little
graph <- graph + scale_x_continuous(breaks = seq(2012, 2014))

# change the y-axis title
graph <- graph + ylab("Cost")

# change the colour of the lines
graph <- graph + scale_colour_brewer("Legend", palette = "Set1")

# the result:
graph