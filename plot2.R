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

png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

#Create graphic except X axis which is added later

with(data, plot(datetime,Global_active_power,type = "l",xlab="", ylab="Global Active Power (kilowatts)", xaxt = "n"))


#Add x axis

r <- as.POSIXct(round(range(data$datetime), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")

dev.off()


