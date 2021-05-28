#code to get file creation date of all the .jpg files in a folder
#with code for extraction/name particular to juv crab pics data folder structure

library(stringr)

#Set working directory path to juvenile photos directory
setwd("/Users/paul.mcelhany/Downloads/juv phots")
#get the name and path to all the folders in the juv photos directory
#these are the tank groups (e.g. "HA", "HB", etc.)
tankGroupFolder <- list.dirs(full.names = TRUE, recursive = FALSE)
#targetpath  <- "C:/Users/OALab/Documents/Juvenile photos/All Photos"

#creat empty data fram
d <- NULL

#loop through all the tank groups
for(i in 1:length(tankGroupFolder)){
  #get the name and path to all the molt folder in the tank group folder
  moltFolder <- list.dirs(path = tankGroupFolder[i],full.names = TRUE, recursive = FALSE)
  #loop through all the molt folders in a given tank group
  for(j in 1:length(moltFolder)){
    #get at list of all the file names in the molt folder
    #List all files in that directory
    fileName <- dir(path = moltFolder[j],pattern=".jpg", full.names = TRUE)
    #get a vector of creation dates
    fileCreationDate <- file.info(fileName)$ctime
    #create crabname for output file
    crabID <- tools::file_path_sans_ext(basename(fileName))
    #temporary data frame
    dTemp <- data.frame(crabID, fileCreationDate)
    dTemp$picStage <- word(moltFolder[j], -1, sep = "/")
    #add to master data frame
    d <- rbind(d, dTemp)
  }
}

# write output to juvenile pics folder (i.e. working directory)
write.csv(d, "fileCreationDates.csv", row.names = FALSE)



##########
#original, one-folder-at-a-time code
#works, but switching to doing all folders at once code

#set the working directory
setwd("C:/Users/OALab/Documents/Juvenile photos/HA (Red)/J7")

#List all files in that directory
fileName <- dir(getwd(),pattern=".jpg")
fileCreationDate <- file.info(fileName)$ctime

d <- data.frame(fileName, fileCreationDate)

write.csv(d, "fileCreationDates.csv", row.names = FALSE)

