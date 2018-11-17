#Set English locale to avoid Week days in foreing language

Sys.setlocale("LC_ALL","English")

#Download and unzip data file only if necesary 

if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

#Load data and subset requested 2 days sample

dataAll<-read.table("household_power_consumption.txt",sep=";",header=TRUE,dec = ".", na.strings="?")
dataAll$Date<-as.Date(dataAll$Date,"%d/%m/%Y" ,optional=TRUE)
data<-subset(dataAll, Date >="2007-02-01" &Date  <="2007-02-02")

#Create date time

data$datetime <- as.POSIXct(paste(data$Date,data$Time))


#Launch png Device

png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

#Generate histogram for Global_active_power frequencies

hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()
