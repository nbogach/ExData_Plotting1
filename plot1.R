library(dplyr)

## Dest Dir
ddir <- "./data"

## Source File
sfile1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


## Dest File for download
dfile1 <- paste(ddir,"exdata-Fdata-Fhosehold_power_consumption.zip", sep="/")

## Dest File after unziping
dfile2 <- paste(ddir,"household_power_consumption.txt", sep="/")

## Dest File after subsetting
dfile3 <- paste(ddir,"household_power_consumption_sub.csv", sep="/")

## Create sub-directory for data if necessary
if (!file.exists(ddir)) {dir.create(ddir)}

## Download data file if necessary
if (!file.exists(dfile1)) {
      download.file(sfile1, dfile1)
}

## Unzip data file if necessary
if (!file.exists(dfile2)) {
      unzip(dfile1, exdir=ddir)
}

## Check if subset exist. If necessary create subset
if (!file.exists(dfile3)) {
      print("Start to creat subset data file.")
      
            df <-tbl_df(read.table(dfile2, header = TRUE, sep=";", stringsAsFactor = FALSE, na.strings = c("?")))

            df<-filter(df,Date=="1/2/2007" | Date=="2/2/2007")
      
            write.csv(df, file=dfile3, row.names = FALSE)
      
} else {
      print("Subset data file detected.")
      
            df <- tbl_df(read.csv(dfile3, stringsAsFactor = FALSE))
      
}

            ### Coerce Data and Time variables to proper format
            
                  df$Time <- as.POSIXct(strptime(paste(df$Date,df$Time,sep=" "), "%d/%m/%Y %H:%M:%S"))
                  
                  df$Date <- as.Date(strptime(df$Date, "%d/%m/%Y"))
    
### Main part of script starts here. 
par(bg="transparent")
with(df, hist(Global_active_power, col="red",
                                   xlab="Global Active Power (kilowatts)",
                                   main="Global Active Power"))

## Save graph as png file
dev.copy(png, file="plot1.png", width=480, height=480, units="px")
dev.off()

