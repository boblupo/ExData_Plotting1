#*******************************************************************************
##  Robert A. Lupo: Programming Assignment 1 - Principles of Analytic Graphics
##                              plot3.R w/ plot3.png
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

#subset by days and Sub_metering values
mydata2 <- subset(mydata, Date == day01 | Date == day02, 
                  select = names(c(mydata["Sub_metering_1"],mydata["Sub_metering_2"], 
                                   mydata["Sub_metering_3"],mydata["Date"],mydata["Time"])))

# convert to numeric for graphing
mydata2$Sub_metering_1 <-  as.numeric(mydata2$Sub_metering_1)
mydata2$Sub_metering_2 <-  as.numeric(mydata2$Sub_metering_2)
mydata2$Sub_metering_3 <-  as.numeric(mydata2$Sub_metering_3)

# Combine Date and Time attributes into new datetime attribute for graphing
mydata2$fulltime <- as.POSIXct(paste(mydata2$Date, mydata2$Time))

# set plot margins
par(mar=c(3,5,2,3))

# Save plot image
png("plot3.png")

# Overlay plots
plot(mydata2$fulltime,  mydata2$Sub_metering_1,  col = "green",type="l",ylab="Energy sub metering",xlab="" )

lines(mydata2$fulltime, mydata2$Sub_metering_2,  col = "red")

lines(mydata2$fulltime, mydata2$Sub_metering_3,  col = "blue")

legend("topright", lty=c(1,1), col = c("green","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.off()