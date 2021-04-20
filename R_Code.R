
# PART 1
#-------------------------------------------------------------------------------
# If you have not followed the previous lab please run the following
#code up to the creation of "sp1" that is used in PART 2 otherwise skip to PART 2
#which is used for another 15 minutes lecture and challenge!
#-------------------------------------------------------------------------------

install.packages("raster", dependencies = TRUE)
install.packages("sp", dependencies = TRUE)
library(raster)
library(sp)

baseDir <- "E:/Research-and-Program-Coordinator-main/Research-and-Program-Coordinator-main/data" 

# read in the file
proLands <- raster::raster(x = paste0(baseDir,"/proAreas.tif"))

# print it out to view some of the metadata
print(proLands)

# use indexing to retrieve specific information
raster::extent(proLands)

# both provide the same information
proLands@extent

# quickly visualize the content
plot(proLands)

#This is another way to check the data
barplot(proLands,
        main = "Number of pixels in each class")

# read in the data
d1 <- read.csv(paste0(baseDir,"/cucurbitaData.csv"))
str(d1)

# view the unique species
unSpec <- unique(d1$taxon)

### subset all records associated with a species
# select our species of interest by indexing the list
species1 <- unSpec[1]

# filter the occurrence data set for all records where the taxon matches our
# species of interest.
d2 <- d1[d1$taxon == species1,]


# d1$taxon == species1 returns a vector of TRUE/FALSE values we use to select
# rows from the d1 dataframe.

# print a summary of the new subset  
str(d2)

### Generate a Spatial Point Dataframe
names(d2)

plot (d2)

# coords = df of longitude, latitude (x,y) values
coordinates <- d2[,c(4,3)] # select all rows in the 3rd and 4th columns
# the order is important, (x,y) which equates to (longitude, latitude).
# data = information associated with the records
# proj4string =

pro4 <- proLands@crs # pull the coordinate reference system from the raster layer

#compile all elements into the function.
sp1 <- sp::SpatialPointsDataFrame(coords = coordinates,
                                  data = d2,
                                  proj4string = pro4)
# view the object
sp1

# view the data
head(sp1@data)

plot(sp1)


# PART 2
#-------------------------------------------------------------------------------
# This part is dedicated to a 15 minutes lecture/challenge for
# Research and Program Coordinator at Colorado State University written by Milad
#-------------------------------------------------------------------------------

#Assign random integers as a new field to use them for clustering
sp1$RValue<- c(sample(1:139))

#Check the result
head(sp1@data)
#-----------------------------------------------------------------------

#Check the data point
plot(sp1)
#----------------------------------------------------------------------
#Create the data frame
d3 <- sp1[]

### Generate a Spatial Point Data frame
names(d3)
#----------------------------------------------------------------------
#Check the result
plot (d3)

head(d3@data)
#----------------------------------------------------------------------

#Prepare the data for K-means

install.packages("animation", dependencies = TRUE)


df <- d3

library(dplyr) # to use glimpse function which provides another way to look at the data 


#Convert the data frame to csv

write.csv(d3,"E:/Research-and-Program-Coordinator-main/Research-and-Program-Coordinator-main/data/d3.csv", row.names = TRUE)

PATH <-"E:/Research-and-Program-Coordinator-main/Research-and-Program-Coordinator-main/data/d3.csv" 

df <- read.csv(PATH) 

glimpse(df) 

#--------------------------------------------------------------------
#Let's run the K-means
 
library(animation) 

#Now we feed the function with df and the number of centers(clusters)!
kmeans.ani(df, 3) 

plot (kmeans.ani()) 

#--------------------------------------------------------------------
