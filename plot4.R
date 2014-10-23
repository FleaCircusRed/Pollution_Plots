# requires ggplot2
library(ggplot2)

# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 4 asks to show data for all coal combustion-related sources
# I've taken this to mean all sources that's shortname contain coal and
# comb or combustion

coal <- grepl("Coal", SCC$Short.Name, ignore.case = TRUE)
comb <- grepl("Comb |Combustion", SCC$Short.Name,  ignore.case = TRUE)

coal_combustion <- SCC[coal & comb, ]

#get the subset of Emissions data that come from coal combustion
coal_emissions <- subset(NEI, NEI$SCC %in% coal_combustion$SCC)

#group emission totals by year
coal_totals <- aggregate(Emissions~year, data=coal_emissions, sum)

#plot and save graph
p <- ggplot(coal_totals, aes(year, Emissions)) + geom_point() + geom_line() +
    labs(title="Nationwide Emissions caused by Coal Combustion") + 
    ylab(expression("Total Emissions PM"[2.5])) +
    xlab("Year")

ggsave("plot4.png", p)