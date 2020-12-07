## File Name:  plot5.R
# Description: This program is used to plot the emission from motor vehicle 
#              sources in Baltimore City from 1999 to 2008 and to conclude the
#              emission changes. 


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

# assume the the Data.Category "Onroad" in SCC representing motor vehicles

data.SCC.vehicle <- data.SCC[data.SCC$Data.Category=="Onroad", ]

# extract Baltimore data

data.PM25.baltimore <- data.PM25[data.PM25$fips=="24510",]

# aggregate emissions by motor vehicles in Baltimore City 

emission.vehicle <- data.PM25.baltimore[(data.PM25.baltimore$SCC %in% data.SCC.vehicle$SCC), ]
emission.vehicle.per.year <- aggregate(Emissions ~ year, emission.vehicle, FUN = sum)


# plot the graph

filename.plot.5 <- "./plot5.png"

bar.colors <- c("red", "yellow", "green", "blue")

png(filename.plot.5, width = 480, height = 480, units = "px")

with(emission.vehicle.per.year, 
     barplot(height = emission.vehicle.per.year$Emissions, 
             names.arg = emission.vehicle.per.year$year, 
             xlab = "Year",
             ylab = "PM2.5 in Tons",
             main = "Motor Vehicle PM2.5 Emission in Baltimore by Year",
             col = bar.colors)
     )

dev.off()
closeAllConnections()

