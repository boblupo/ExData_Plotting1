#*******************************************************************************
##  Robert A. Lupo: Programming Assignment 1 - Principles of Analytic Graphics
##                              plot2.R w/ plot2.png
#*******************************************************************************

# set working drectory
setwd("~/GitHub/ExData_Plotting1")

# set variables to represent days requested and file name
day01 <- "2007-02-01"
day02 <- "2007-02-02"
a     <- "household_power_consumption.txt"

# read data file with no fancy filtering
mydata <-  read.table(a, sep=";", header = TRUE)

# convert Date attribute to Date object for subsetting
mydata$Date <-as.Date(mydata$Date, format = "%d/%m/%Y")

#subset by days and non-empty Global_active_power
mydata2 <- subset(mydata, (Date == day01 | Date == day02), 
                  select = names(c(mydata["Global_active_power"],mydata["Date"],mydata["Time"])))


# Combine Date and Time attributes into new datetime attribute for graphing
mydata2$datetime <-  as.POSIXct(paste(mydata2$Date, mydata2$Time))

# convert to numeric for graphing
# value offset by division by 500 to match assignment.
# with no offset 'Y' axis corresponds to the original data values in data file

mydata2$Global_active_power <-  (as.numeric(mydata2$Global_active_power))/500 


#plot with lines connecting points
png("plot2.png")
with(mydata2,plot(datetime,Global_active_power, type='l',xlab="", 
                  main="Global Active Power (kilowatts)"))
dev.off()