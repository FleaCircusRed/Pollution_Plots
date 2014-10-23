# requires ggplot2
library(ggplot2)

# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get total emmissions by year and by type for baltimore
baltimore <- subset(NEI, fips == "24510")
totals <- aggregate(Emissions~year+type, data=baltimore, sum)
totals$type[totals$type == "NON-ROAD"] <- "Off-Road"
totals$type[totals$type == "ON-ROAD"] <- "On-Road"
totals$type[totals$type == "POINT"] <- "Point"
totals$type[totals$type == "NONPOINT"] <- "Non-Point"
totals$type <- as.factor(totals$type)

p <- ggplot(totals, aes(year, Emissions, group = type, color = type) 
            ) + geom_point() + geom_line() + 
    labs(title="Baltimore Total Emissions by Type") + 
    ylab(expression("Total Emissions PM"[2.5])) +
    xlab("Year")

ggsave("plot3.png", p)


