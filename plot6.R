# requires ggplot2
library(ggplot2)

# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 6 asks to plot the Emissions from Motor vehicles in Baltimore and LA 
# County I take Motor vehicles to mean mean self propelled on road vehicles that does 
# use rails excluding off road vehicles and heavy construction.  This is based
# upon the wikipedia article for motor vehicles which contains the following 
# quote:
#
# "The U.S. publisher Ward's, estimate that as of 2010 there were 1.015 billion 
# motor vehicles in use in the world. This figure represents the number of cars; 
# light, medium and heavy duty trucks; and buses, but does not include off-road 
# vehicles or heavy construction equipment."

# get baltimore and LA county emissions data
emissions <- subset(NEI, fips == "24510" | fips == "06037")

# get onroad motor vehicle sources
on_road_sources <- subset(SCC, Data.Category == "Onroad")

# filter baltimore emission data by motor vehicle sources
vehicle_emissions <- subset(emissions, emissions$SCC %in% on_road_sources$SCC)

# get the sum for each year of emissions
totals <- aggregate(Emissions~year + fips, data=vehicle_emissions, sum)

# replace fips with county name
totals$fips[totals$fips == "24510"] <- "Baltimore"
totals$fips[totals$fips == "06037"] <- "LA County"

# plot and save the emissions for motor vehicles by year
p <- ggplot(totals, aes(year, Emissions, group = fips, color = fips)) + geom_point() + geom_line() +
    labs(title="Baltimore & LA County Motor Vehicle Emissions ") + 
    ylab(expression("Total Emissions PM"[2.5])) +
    xlab("Year") +
    theme(plot.title = element_text(size = rel(1)))

ggsave("plot6.png", p, width = 4.5, height = 3)

# As shown in the plot, LA county motor vehicle emissions saw greater change
# during 1999 - 2008
