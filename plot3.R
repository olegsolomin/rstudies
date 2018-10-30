#set directory for downloading
path<-"data_for_assignment"
#path to data in web
urlZip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#check and make a directory for downloading
if(!file.exists(path)) {
dir.create(path)
}
#downloading data
if(!file.exists("data_for_assignment/dataFiles.zip")) {
download.file(urlZip, destfile=paste0(path,"/" ,"dataFiles.zip"), method = "curl")
}
#unpacking data
if(!file.exists("data_for_assignment/household_power_consumption.txt")) {
unzip(zipfile = paste0(path,"/" ,"dataFiles.zip"), exdir = path, overwrite = TRUE)
}
#setting file
path<-"data_for_assignment"
file <- "household_power_consumption.txt"
fullpath<-paste0(path,"/",file)
fine_data<-read.csv.sql(file = fullpath, sql = "select * from file where Date =='1/2/2007' or Date =='2/2/2007'" , sep = ";")
closeAllConnections()

# changing format of Date& Time
fine_data$DateTime <-strptime(paste(fine_data$Date,fine_data$Time), "%d/%m/%Y %H:%M:%S")

#setting file name and size
png("Plot3.png", width = 480, height = 480)
#plotting
par(mfcol=c(1,1))
plot(fine_data$DateTime, fine_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(fine_data$DateTime, fine_data$Sub_metering_2, type = "l", col="red")
lines(fine_data$DateTime, fine_data$Sub_metering_3, type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1)

#closing session
dev.off()
