#Exploratory Data Analysis - Week 1 Asignment

filename <- "exdata_data_household_power_consumption.zip"

#Unzipfile
if(!file.exists("household_power_consumption.txt")){
  unzip(filename)
}

#read data into R
householdpower <- read.table("household_power_consumption.txt",header=T, sep = ";")

subpower <- subset(householdpower, householdpower$Date == "1/2/2007" | householdpower$Date == "2/2/2007" )

#Convert Date column to date format
#subpower$Date <- as.Date(subpower$Date, format = "%d/%m/%Y")
datetime <- strptime(paste(subpower$Date, subpower$Time, sep= " "), "%d/%m/%Y %H:%M:%S")

#feature engineering for all graphs
GlobalActivePower <- as.numeric(as.character(subpower$Global_active_power))
subMetering1 <- as.numeric(subpower$Sub_metering_1)
subMetering2 <- as.numeric(subpower$Sub_metering_2)
subMetering3 <- as.numeric(subpower$Sub_metering_3)

#open the PNG file
png("plot4.png", width=480, height=480)

#allow for four graphs to be added
par(mfrow= c(2,2))

#create chart1
plot(x = datetime
     , y = GlobalActivePower
     , type = "l"
     , xlab = ""
     , ylab = "Global Active Power (kilowatts)")

#create chart2
plot(x = datetime, y = as.numeric(as.character(subpower$Voltage))
     , type = "l", xlab = "datetime", ylab = "Voltage")

#create chart3
plot(x = datetime, y = subMetering1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(x = datetime, y = subMetering2, type = "l", col = "red")
lines(x = datetime, y = subMetering3, type = "l", col = "blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 ")
       , lty=1, lwd = 2.5, cex = 0.6, bty = "n")

#create chart4
plot(x = datetime, y = as.numeric(as.character(subpower$Global_reactive_power))
     , type = "l"
     , xlab = "datetime"
     , ylab = "Global_reactive_power")

#close the pdf file device
dev.off()