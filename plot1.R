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
subpower$Date <- as.Date(subpower$Date, format = "%d/%m/%Y")

#Set data for graph
globalactivepower <- as.numeric(as.character(subpower$Global_active_power))

#open the PNG file
png("plot1.png", width=480, height=480)

#create histogram
hist(globalactivepower, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

#close the pdf file device
dev.off()