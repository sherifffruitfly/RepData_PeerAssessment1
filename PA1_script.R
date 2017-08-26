# script to answer the PA1 questions.

# get data if not already present
filename <- "activity.csv"
if (!file.exists(filename)) {
  download <- download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", destfile = "temp.zip")
  unzip("temp.zip")
  unlink("temp.zip")
}

# create raw dataframe
activity_raw <- read.csv("activity.csv")

# add helper columns
library(stringr)
library(lubridate)
activity_raw$tod_str <- paste(str_pad(as.character(activity_raw$interval), 4, pad = "0"), ":00", sep="")
activity_raw$tod_str <- paste(substr(activity_raw$tod_str, 1, 2), ":", substr(activity_raw$tod_str, 3, length(activity_raw$tod_str)), sep="")
activity_raw$tod_str <- format(strptime(activity_raw$tod_str, format="%H:%M:%S"), "%I:%M:%S %p")
activity_raw$datetime <- as.POSIXct(paste(activity_raw$date, activity_raw$tod_str), format="%Y-%m-%d %I:%M:%S %p")
