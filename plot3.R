library(dplyr)

plot3 <- function() {
  # download dataset
  download_dataset()
  
  #read file
  complete_ds <- as_tibble(read.table(unzip("dataset.zip", "household_power_consumption.txt"), header = TRUE, sep=";"))
  
  #get data from 2007-02-01 and 2007-02-02
  ds <- complete_ds %>% filter(Date %in% c( "1/2/2007", "2/2/2007"))
  
  #convert types
  ds <- ds %>% mutate_at("Global_active_power", as.numeric) %>%
    mutate(Datetime = as.POSIXct(paste(ds$Date, ds$Time), format="%d/%m/%Y %H:%M:%S"))
  
  #generate plot
  png("plot3.png", width = 480, height = 480)
 
  Sys.setlocale("LC_TIME", "C") #since I'm at a non-English locale
  plot(ds$Datetime, ds$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
  lines(ds$Datetime, ds$Sub_metering_2, col="red")
  lines(ds$Datetime, ds$Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1) 
  
  dev.off() 
}

download_dataset <- function() {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "dataset.zip", method = "curl")
}