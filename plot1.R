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

#plotting
par(mfcol=c(1,1))
hist(fine_data$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
#saving to File
dev.copy(png,"Plot1.png", width = 480, height = 480)
dev.off()
