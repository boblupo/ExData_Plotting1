#*******************************************************************************
##  Robert A. Lupo: Programming Assignment 1 - Principles of Analytic Graphics
##                              plot1.R w/ plot1.png
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
mydata2 <- subset(mydata, (Date == day01 | Date == day02) & 
                    Global_active_power !="?", select = names(c(mydata["Global_active_power"])))

# convert to numeric for graphing
mydata2$Global_active_power <- as.numeric(mydata2$Global_active_power)

#plot histogram. Saved as plot1.png

png("plot1.png")
hist(mydata2$Global_active_power, col ="red",main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()