# File Name:   plot6.R
# Description: This program is used to plot the emission from motor vehicle 
#              sources in Baltimore City and Los Angeles County from 1999 to 
#              2008 and to conclude which city has greater emission changes. 


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

# data preparation

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

# assume the the Data.Category "Onroad" in SCC representing motor vehicles

data.SCC.vehicle <- data.SCC[data.SCC$Data.Category=="Onroad", ]

# extract Baltimore data

data.PM25.baltimore <- data.PM25[data.PM25$fips=="24510",]

# extract Los Angeles data

data.PM25.la <- data.PM25[data.PM25$fips=="06037",]

# extract vehicle emissions of PM2.5 for Baltimore

emission.vehicle.baltimore <- data.PM25.baltimore[(data.PM25.baltimore$SCC %in% data.SCC.vehicle$SCC), ]

# extract vehicle emissions of PM2.5 for Los Angeles

emission.vehicle.la <- data.PM25.la[(data.PM25.la$SCC %in% data.SCC.vehicle$SCC), ]

# add city into corresponding data set

emission.vehicle.baltimore$City <- "Baltimore City"
emission.vehicle.la$City <- "Los Angeles County"

# merge two data sets into one

emission.vehicle.combine <- rbind(emission.vehicle.baltimore, emission.vehicle.la)

# plot the graph

filename.plot.6 <- "./plot6.png"

library(ggplot2)

png(filename.plot.6, width = 640, height = 480, units = "px")

ggp <- ggplot(emission.vehicle.combine,
              aes(x = factor(year),
                  y = Emissions,
                  fill = City
                  )
              ) +
    geom_bar(aes(fill = year), stat = "identity") +
    facet_grid(scales = "free", space = "free", . ~ City) +
    guides(fill = FALSE) +
    ylab("PM2.5 in Tons") +
    xlab("Year") +
    ggtitle("PM2.5 Emission of Motor Vehicles in Baltmore and L.A., 1990-2008") 

print(ggp)

dev.off()
closeAllConnections()

