#getwd()
#setwd('C:/Users/smoturi/Downloads/RProject/Course4/Project')

library(dplyr)

#Download the Electric power consumption [20 Mb] zip file from the below link to your working directory:
If(!file.exists('household_power_consumption.zip')){
        FileUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
        download.file(FileUrl,destfile = "household_power_consumption.zip",method = "curl")
}

# Unzip the downloaded zip file in same location
Unzipfile <- unzip("household_power_consumption.zip") 

#Read this data into R and Filter the dataset for only two dates 2/1/2007 and 2/2/2007 and store the data in a new variable Consumption_Data
data <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
#summary(data)

Consumption_Data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
#summary(Consumption_Data)

# Convert the Character class types to Numeric for below columns
Consumption_Data$Global_active_power <- as.numeric(Consumption_Data$Global_active_power)
Consumption_Data$Global_reactive_power <- as.numeric(Consumption_Data$Global_reactive_power)
Consumption_Data$Voltage <- as.numeric(Consumption_Data$Voltage)
Consumption_Data$Sub_metering_1 <- as.numeric(Consumption_Data$Sub_metering_1)
Consumption_Data$Sub_metering_2 <- as.numeric(Consumption_Data$Sub_metering_2)
Consumption_Data$Sub_metering_3 <- as.numeric(Consumption_Data$Sub_metering_3)

#summary(Consumption_Data)
#sum(is.na(Consumption_Data$Global_active_power))


#concatenated the Date and Time using paste and converted to POSXIT using strptime function
Consumption_Data$datetime <- strptime(paste(Consumption_Data$Date, Consumption_Data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#summary(Consumption_Data)

#Make a Plot for Global Active Power
plot(Consumption_Data$datetime, Consumption_Data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Save the plot as a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png,"plot2.png",width = 480,height=480)

dev.off()