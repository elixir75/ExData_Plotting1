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

##PLOT HISTOGRAM
hist(data,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png")
dev.off()
