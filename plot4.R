install.packages("tidyverse")
install.packages("dplyr")
install.packages("rlang")
library(dplyr)
library(tidyverse)

#Reading and Data filtering by dates 
datos<- read.csv2("household_power_consumption.txt")
summary(datos)
str(datos)

table(datos$Date)

dat<-datos%>%filter(Date %in% c("1/2/2007", "2/2/2007"))
dat

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat$Time <- strptime(dat$Time, format="%H:%M:%S")
dat[1:1440,"Time"] <- format(dat[1:1440,"Time"],"2007-02-01 %H:%M:%S")
dat[1441:2880,"Time"] <- format(dat[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(dat,{
    plot(dat$Time,as.numeric(as.character(dat$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
    plot(dat$Time,as.numeric(as.character(dat$Voltage)), type="l",xlab="datetime",ylab="Voltage")
    plot(dat$Time,dat$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(dat,lines(Time,as.numeric(as.character(Sub_metering_1))))
    with(dat,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
    with(dat,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    plot(dat$Time,as.numeric(as.character(dat$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})
