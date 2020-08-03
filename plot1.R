install.packages("tidyverse")
install.packages("dplyr")
install.packages("rlang")
library(dplyr)
library(tidyverse)


datos<- read.csv2("household_power_consumption.txt")
summary(datos)
str(datos)

table(datos$Date)

dat<-datos%>%filter(Date %in% c("1/2/2007", "2/2/2007"))
dat
