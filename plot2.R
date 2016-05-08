setwd("~/Coursera/ExploratoryDataAnalysis/Project1/")
library(sqldf)
library(data.table)

## EXTERNAL FILE VARIABLES
urlfp <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
locald <- file.path("./data")
localf <- file.path("./data/household_power_consumption.txt")

## IF DATA FILE DOESN'T EXIST, DOWNLOAD AND UNZIP
if (!file.exists(localf))
{
        download.file(urlfp,destfile ="household_power_consumption.zip")
        unzip("household_power_consumption.zip", exdir=locald )
}
## READ FILE TO DATA TABLE REMOVE ROWS
mydata = fread(localf, stringsAsFactors = "FALSE")
mydata= subset(mydata,mydata$Global_reactive_power!="?")

## SUBSET USING DATE COLUMN TO FILTER ROWS
mysubset= mydata[as.Date(mydata$Date, format="%d/%m/%Y") >= as.Date("2007-02-01")
                 & as.Date(mydata$Date, "%d/%m/%Y") <= as.Date("2007-02-02")]

## CHANGE COLUMN DATA TO NUMERIC
data <- as.numeric(mysubset$Global_active_power)

## GET DATETIME
datetime <- strptime(paste(mysubset$Date, mysubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

##PLOT 
plot(datetime, data, type="l", xlab="", ylab="Global Active Power (kilowatts)")
hist(data, ylab="Global Active Power (kilowatts)")
dev.copy(png,file="plot2.png")
dev.off()
