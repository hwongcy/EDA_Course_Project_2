# File Name:   plot4.R
# Description: This program is used to plot the emission from coal combustion 
#              related sources from 1999 to 2008 and to conclude the esmission 
#              changes. 


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


# extract Coal Combustion from SCC

data.SCC.coal <- data.SCC[grepl("Fuel Comb.*Coal", data.SCC$EI.Sector), ]

# aggregate total emissions of PM2.5 for Coal Combustion only.

emission.coal <- data.PM25[(data.PM25$SCC %in% data.SCC.coal$SCC), ]
emission.coal.per.year <- aggregate(Emissions ~ year, emission.coal, FUN = sum)

# plot the graph

filename.plot.4 <- "./plot4.png"

bar.colors <- c("red", "yellow", "green", "blue")

png(filename.plot.4, width = 480, height = 480, units = "px")

with(emission.coal.per.year, 
     barplot(height = emission.coal.per.year$Emissions/1000, 
             names.arg = emission.coal.per.year$year, 
             xlab = "Year",
             ylab = "PM2.5 in Kilotons",
             main = "PM2.5 Emission of Coal Combustion by Year",
             col = bar.colors
             )
     )

dev.off()
closeAllConnections()

