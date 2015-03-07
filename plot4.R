##########################################
### Exploratary Data Analysis - Week 1 ###
##########################################

rm(list=ls()) # clear the environnment of all objects defined previously
getwd()   # get working directory

# download and unzip data (if not already)
fileUrl = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./household_power_consumption.zip")) { 
    download.file(fileUrl, "./household_power_consumption.zip") 
} 
unzip("./household_power_consumption.zip")

# load data only for 2007/02/01 and 2007/02/02
subdata = read.csv("household_power_consumption.txt", sep = ";", header = T,
                   skip = 66636, nrows = 2880, na.strings = "?")
colnames(subdata) = c("Date", "Time", "Global_active_power", 
                      "Global_reactive_power", "Voltage", "Global_intensity", 
                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
datetime = paste(subdata$Date, subdata$Time)
subdata$DateTime = strptime(datetime, "%d/%m/%Y %H:%M:%S")


## Plot4
png(filename = "plot4.png", width = 480, height = 480, 
    units = "px", bg = "transparent") 
par(mfrow = c(2, 2)) 
# Top-left 
plot(subdata$DateTime, subdata$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power") 
# Top-right 
plot(subdata$DateTime, subdata$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage") 
# Bottom-left 
plot(subdata$DateTime, subdata$Sub_metering_1, type = "l", col = "black", 
     xlab = "", ylab = "Energy sub metering") 
lines(subdata$DateTime, subdata$Sub_metering_2, col = "red") 
lines(subdata$DateTime, subdata$Sub_metering_3, col = "blue") 
legend("topright", bty = "n", col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1) 
## Bottom-right 
plot(subdata$DateTime, subdata$Global_reactive_power, type = "l", col = "black",
     xlab = "datetime", ylab = colnames(subdata)[4]) 
dev.off()