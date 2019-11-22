library(dplyr)
#get the data

link<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(link,destfile="./ExPlot.zip", mode="wb")
unzip("./ExPlot.zip")

Variables<-read.table("./household_power_consumption.txt", nrows=1, header = FALSE, sep=';', stringsAsFactors = FALSE)
Data<-read.table("./household_power_consumption.txt", skip=2, header = FALSE, sep=';')

#change column names
colnames(Data)<-Variables[1,]

#change date into date
Data$Date<-as.Date(Data$Date, format="%d/%m/%Y")

#only grab between dates 2007-02-01 and 2007-02-02
Date1<-as.Date("2007-02-01")
Date2<- as.Date("2007-02-02")
dataset<-filter(Data, Date>=Date1&Date<=Date2)
