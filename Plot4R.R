library(dplyr)
library(ggplot2)
library(datasets)
#get the data

link<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(link,destfile="./ExPlot.zip", mode="wb")
unzip("./ExPlot.zip")

Variables<-read.table("./household_power_consumption.txt", nrows=1, header = FALSE, sep=';', stringsAsFactors = FALSE)
Data<-read.table("./household_power_consumption.txt", skip=2, header = FALSE, sep=';')

#change column names
colnames(Data)<-Variables[1,]

#change date into date and time into time
Data$Date<-as.Date(Data$Date, format="%d/%m/%Y")
Data$DateTime<-as.POSIXct(paste(Data$Date, Data$Time), format="%Y-%m-%d %H:%M:%S")

#only grab between dates 2007-02-01 and 2007-02-02
Date1<-as.Date("2007-02-01")
Date2<- as.Date("2007-02-02")
dataset<-filter(Data, Date>=Date1&Date<=Date2)

#change datatype
dataset$Global_active_power<-as.numeric(as.character(dataset$Global_active_power))
dataset$Global_reactive_power<-as.numeric(as.character(dataset$Global_reactive_power))
dataset$Sub_metering_3<-as.numeric(as.character(dataset$Sub_metering_3))
dataset$Sub_metering_2<-as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_1<-as.numeric(as.character(dataset$Sub_metering_1))
dataset$Voltage<-as.numeric(as.character(dataset$Voltage))

###plot4: 4 charts

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#top left chart
{with(dataset, plot(DateTime,Global_active_power,type="l", xlab = "", ylab="Global Active Power (kilowatts)"))}

#top right chart
{with(dataset, plot(DateTime,Voltage,type="l")) }

#bottom left chart
{with(melt,plot(DateTime, value, type="l", ylab="Energy sub metering", xlab = ""))
  with(subset(melt, variable=="Sub_metering_1"), lines(DateTime, value, col="black"))
  with(subset(melt, variable=="Sub_metering_2"), lines(DateTime, value, col="red"))
  with(subset(melt, variable=="Sub_metering_3"), lines(DateTime, value, col="blue"))
  legend("topright", lty=1,col=c("black","red","blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))}

#bottom right chart
{with(dataset, plot(DateTime,Global_reactive_power,type="l"))}

dev.off()