#*******************************************************************************
##  Robert A. Lupo: Programming Assignment 1 - Principles of Analytic Graphics
##                              plot4.R w/ plot4.png
#*******************************************************************************

#-------------------------------------------------------------------------------
# set working drectory
setwd("~/GitHub/ExData_Plotting1")

# set variables to represent days requested and file name
day01 <- "2007-02-01"
day02 <- "2007-02-02"
a <- "household_power_consumption.txt"


# read data file with no fancy filtering
mydata <-  read.table(a, sep=";", header = TRUE)

# convert Date attribute to Date object for subsetting
mydata$Date <-as.Date(mydata$Date, format = "%d/%m/%Y")

#subset by days and attributes
mydata2 <- subset(mydata, (Date == day01 | Date == day02), 
                  select = names(c(mydata["Sub_metering_1"],mydata["Sub_metering_2"], 
                                   mydata["Sub_metering_3"],mydata["Date"],mydata["Time"],mydata["Global_active_power"], 
                                   mydata["Global_reactive_power"],mydata["Voltage"])))


# convert to numeric for graphing
mydata2$Sub_metering_1        <-  as.numeric(mydata2$Sub_metering_1)
mydata2$Sub_metering_2        <-  as.numeric(mydata2$Sub_metering_2)
mydata2$Sub_metering_3        <-  as.numeric(mydata2$Sub_metering_3)
mydata2$Voltage               <-  as.numeric(mydata2$Voltage)

# convert to numeric for graphing
# value offset by division by 500 to match assignment.
# with no offset 'Y' axis corresponds to the original data values in data file
mydata2$Global_active_power   <-  (as.numeric(mydata2$Global_active_power))/500
mydata2$Global_reactive_power <-  (as.numeric(mydata2$Global_reactive_power))/500

# Combine Date and Time attributes into new datetime attribute for graphing
mydata2$datetime              <-  as.POSIXct(paste(mydata2$Date, mydata2$Time))

# Save plot image -- must be called before par()
png("plot4.png")

#set multiple graph plots format
par(mfrow = c(2,2))

# plot
with(mydata2, {
  plot(datetime,Global_active_power, type='l', ylab="Global Active Power",xlab="")
  
  plot(datetime,Voltage, type='l',ylab="Voltage")
  
  plot(datetime,Sub_metering_1,  col = "green",type="l",ylab="Energy sub metering",xlab="" )
  
  lines(datetime,Sub_metering_2,  col = "red")
  
  lines(datetime, Sub_metering_3,  col = "blue")
  
  legend("topright",bty="n", lty=c(1,1), col = c("green","red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  
  plot(datetime,Global_reactive_power, type='l',ylab="Global_reactive_power",xlab="")  
  
})
dev.off()  
