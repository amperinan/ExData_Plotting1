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

# calling the basic plot functions
plot(dat$Time,dat$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(dat,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(dat,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(dat,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# annotating graph
title(main="Energy sub-metering")
