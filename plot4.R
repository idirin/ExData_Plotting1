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

png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

#Deefine 2x2 layout

par(mfrow=c(2,2))

#Add 1st Graphic

with(data, plot(datetime,Global_active_power,type = "l",xlab="", ylab="Global Active Power (kilowatts)", xaxt = "n"))
r <- as.POSIXct(round(range(data$datetime), "days"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")

#Add 2nd Graphic

with(data, plot(datetime,Voltage,type = "l",xaxt = "n"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")


#Add 3rd Graphic

with(data, plot(datetime,Sub_metering_1,type = "s",xlab="", ylab="Energy Submetering", xaxt = "n")     )
with(data, lines(datetime,Sub_metering_2,col="red"))
with(data, lines(datetime,Sub_metering_3,col="blue"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,lwd=1)

#Add 4th Graphic

with(data, plot(datetime,Global_reactive_power,type = "l",  yaxt = "n" , xaxt = "n"))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
axis(2,at = seq(0:0.5,by=0.1),labels=TRUE, tick = TRUE)

dev.off()


