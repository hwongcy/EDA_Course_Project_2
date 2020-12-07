# Exploratory Data Analysis Course Project 2


## Purpose

The purpose of this project to explore the fine particulate matter (PM2.5) poluution in the United States in 1999, 2002, 2005 and 2008 by using the given datasets. 

Below questions are needed to answer:

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

Datasets to be used are provided from the course website as shown below:

<https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>

There are two datasets provided which are

- **summarySCC_PM25.rds**, contains a data frame with all of the PM2.5 emission data for 1999, 2002, 2005 and 2008. Corresponding fields are as shown below:

| Field     | Description                                             |
|:----------|:--------------------------------------------------------|
| fips      | A 5-digit number repsents U.S. county                   |
| SCC       | A digit string repsents source                          |
| Pollutant | A string indicating the pollutant                       |
| Emissions | Amount of PM2.5 emitted, in tons                        |
| type      | Type of sources (point, non-point, on-road, or non-road |
| year      | The year of emissions recorded                          |

- **Source_Classification_Code.rds**, provides a mapping from the SCC digit strings in the emission table to the actual name of the PM2.5 source.



## Data Preparation

Dataset will be downloaded and unzipped by *download.file* and *unzip* in the current directory. For example,

```{r download_n_unzip}
data.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(data.url, destfile = "./data/Dataset.zip", method = "curl")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
```

Dataset will be retrieved by using **readRDS()** as shown below:

```{r read_files}
data.PM25 <- readRDS("./data/summarySCC_PM25.rds")
data.SCC <- readRDS("./data/Source_Classification_Code.rds")
```

