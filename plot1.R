library(dplyr)

plot1 <- function() {
  # download dataset
  download_dataset()
  
  #read file
  complete_ds <- as_tibble(read.table(unzip("dataset.zip", "household_power_consumption.txt"), header = TRUE, sep=";"))
  
  #get data from 2007-02-01 and 2007-02-02
  ds <- complete_ds %>% filter(Date %in% c( "1/2/2007", "2/2/2007"))

  #convert types
  ds <- ds %>% mutate_at("Global_active_power", as.numeric)

  png("plot1.png", width = 480, height = 480)
  hist(ds$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off() 
}

download_dataset <- function() {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "dataset.zip", method = "curl")
}