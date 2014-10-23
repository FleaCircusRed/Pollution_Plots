# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get total emmissions by year for baltimore
baltimore <- subset(NEI, fips == "24510")
baltimore <- rowsum(baltimore$Emissions, baltimore$year)
baltimore <- cbind(baltimore, c(1999,2002,2005,2008))


# generate plot as png
png(filename = "plot2.png")

plot(baltimore[,2], baltimore[,1], type = "l", 
     ylab = expression('Total Emissions - PM'[2.5]), xlab = "Year")
title(main = "Baltimore, Maryland")

dev.off()