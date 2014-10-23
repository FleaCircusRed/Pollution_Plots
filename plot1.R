# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get total emmissions by year
total_emissions <- rowsum(NEI$Emissions, NEI$year)
total_emissions <- cbind(total_emissions, c(1999,2002,2005,2008))


# generate plot as png
png(filename = "plot1.png")

plot(total_emissions[,2], total_emissions[,1], type = "l", 
     ylab = expression('Total Emissions - PM '[2.5]), xlab = "Year")

dev.off()
