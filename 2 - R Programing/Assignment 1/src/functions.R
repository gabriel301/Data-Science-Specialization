##Script functions
##PART 1
pollutantmean <- function(directory,pollutant,id=1:332)
{
  ##get the list of files of the directory
  temp = list.files(path=directory,pattern="*.csv")
  ##array to store all values
  ##temp is a vector from 1 to 332 which stores all filenames of the files
  ##of the folder. Id is the range of files we want to read
  ##dataframe to store all data
  dat<-data.frame()
  for (i in id)
  {
    ##read the file
    file <- read.csv(paste(directory,temp[i],sep="/"))
    ##bind the content of the loaded file with the dataset which stores all data
    dat<-rbind(dat,file)
  }
  ##dat is a dataset. Extract the polutant column
  filtered <- dat[,pollutant]
  ##filtered is a vector which stores all data contained in "pollutant" column
  ##strips out all of NA values
  filtered <- filtered[!is.na(filtered)]
  ##print the mean
  mean(filtered) 
}
 ##Part2
complete<-function(directory,id=1:332)
{
  ##get the list of files of the directory
  temp = list.files(path=directory,pattern="*.csv")
  
  ##Arrays to store the id and the nobs
  ids<-integer(length = length(id))
  nobs <- integer(length = length(id))
  ##creating the dataset based on the arrays (all zero values)
  dat<-data.frame(id,nobs)
  ##Cont to assign values to the dataframe
  cont<-1
  for (i in id)
  {
    ##read the file
    file <- read.csv(paste(directory,temp[i],sep="/"))
    ##assign values
    dat[cont,1]<-i
    dat[cont,2]<-sum(complete.cases(file))
    cont<-cont+1
  }
  print(dat)
}

##Part 3
corr<-function(directory,threshold=0)
{
  ##get the list of files of the directory
  temp = list.files(path=directory,pattern="*.csv")

  ##Vector to store the results
  result<-numeric()
  for (i in 1:length(temp))
  {
    ##reads the file
    file <- read.csv(paste(directory,temp[i],sep="/"))
    ##Checks if the current file has more complete cases than the threshold
   if(sum(complete.cases(file))> threshold)
   {
     ##strips out rows with NA's
     file<-file[complete.cases(file),]
     ##gets all the rows os sulfate variable
     x<-file[,"sulfate"]
     
     ##gets all the rows os sulfate nitrate
     y<-file[,"nitrate"]
     ##attach to the vector result the correlation between both
     result<-c(result,cor(x,y))
   }
    
  }
  result
}

