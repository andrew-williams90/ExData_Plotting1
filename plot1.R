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

### plot data
hist(powerData$Global_active_power, col = 'red', main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')

### these functions save the plot on the screen device 
### to a .png file
dev.copy(device = png, filename = 'plot1.png')
dev.off()
