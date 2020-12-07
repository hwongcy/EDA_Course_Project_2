# File Name:   plot2.R
# Description: This program is used to use the base plotting system to plot the
#              total PM2.5 emission in Baltimore City. We will conclude whether
#              the total PM2.5 is decreased from 1999 to 2008. 


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

data.baltimore <- data.PM25[data.PM25$fips=="24510",]

# aggregate Baltimore's emissions of PM2.5

emission.per.year <- aggregate(Emissions ~ year, data.baltimore, FUN = sum)

# plot the graph

filename.plot.2 <- "./plot2.png"

bar.colors <- c("red", "yellow", "green", "blue")

png(filename.plot.2, width = 480, height = 480, units = "px")

with(emission.per.year, 
     barplot(height = emission.per.year$Emissions/1000, 
             names.arg = emission.per.year$year, 
             xlab = "Year",
             ylab = "PM2.5 in Kilotons",
             main = "Baltimore PM2.5 Emission by Year",
             col = bar.colors)
     )

dev.off()
closeAllConnections()

