# File Name:   plot3.R
# Description: This program is used to use ggplot2 to plot the emission of
#              Baltimore City by source types, which are "point", "nonpoint", 
#              "onroad" and "nonroad", respectively. We will conclude which of 
#              these types have seen decreases or increases in emission from 
#              1999 to 2008. 


# download and unzip the data file

data.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
data.filename.1 <- "./data/summarySCC_PM25.rds"
data.filename.2 <- "./data/Source_Classification_Code.rds"

if(!file.exists("./data")) {
    dir.create("./data")
}

if(!file.exists(data.filename.1)) {
    download.file(data.url, destfile = "./data/Dataset.zip", method = "curl")
    unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
}

# load data from summarySCC_PM25.rds

if(exists("data.PM25")) {
    rm(data.PM25)
}
data.PM25 <- readRDS(data.filename.1)

# load data from Source_Classification_Code.rds

if(exists("data.SCC")) {
    rm(data.SCC)
}
data.SCC <- readRDS(data.filename.2)

# extract Baltimore data

data.PM25.baltimore <- data.PM25[data.PM25$fips=="24510",]

# plot the graph

filename.plot.3 <- "./plot3.png"

library(ggplot2)

png(filename.plot.3, width = 960, height = 480, units = "px")

ggp <- ggplot(data = data.PM25.baltimore,
              aes(x = factor(year),
                  y = Emissions,
                  fill = type
                  )
              ) +
    geom_bar(stat = "identity") +
    facet_grid(. ~ type) +
    xlab("Year") +
    ylab("PM2.5 Emission in Tons") +
    ggtitle("Baltimore PM2.5 Emission by Source Type")

print(ggp)

dev.off()
closeAllConnections()

