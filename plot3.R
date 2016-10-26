### read in data
powerDataRaw = data.table::fread(input = '~/Downloads/household_power_consumption.txt', sep = ';')

dates = c('1/2/2007','2/2/2007')

### subset and format data
powerData = powerDataRaw[powerDataRaw$Date %in% dates,]
powerData = droplevels(powerData)
powerData = as.data.frame(powerData)
powerData[,3:ncol(powerData)] = lapply(powerData[,3:ncol(powerData)], as.numeric)
powerData$Date = as.Date(powerData$Date, format = '%d/%m/%Y')
powerData$Time = format(strptime(powerData$Time, format = "%H:%M:%S"), '%T')
powerData$datetime = as.POSIXct(paste(powerData$Date, powerData$Time), format="%Y-%m-%d %T")

### plot data directly to .png to solve for legend sizing issues
png('plot3.png')

plot(powerData$datetime, powerData$Sub_metering_1, type = 'n',
     ylab = 'Energy sub metering', xlab = '')
lines(powerData$datetime, powerData$Sub_metering_1)
lines(powerData$datetime, powerData$Sub_metering_2, col = 'red')
lines(powerData$datetime, powerData$Sub_metering_3, col = 'blue')
legend('topright', 
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty = 1,
       col = c('black','red','blue')
)

dev.off()
