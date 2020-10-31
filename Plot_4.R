##First Set directory in order to get the files easy
##It will depend on where is the zip file you download
setwd("C:/users/jusnfidel18/Desktop/Coursera/ExporData")
#Reads in data from file then subsets data for specified dates
info <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
info[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
info[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
info <- info[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
plot(info[, dateTime], info[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
