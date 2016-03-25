rankall <- function(outcome,num) {
  
  sortByState<-function(dat,outcome,na.last=NA)
  {
    dat<-dat[order(as.numeric(dat[,outcome]),dat[,"Name"],na.last = na.last,decreasing = FALSE),]
    dat
  }
 
  rankByState<-function(dat,num)
  {
    #check if the num is a character and then assign the proprer values
    if(!is.numeric(num))
      if(length(grep("best",num,fixed = TRUE)))
        num<-1L
      else if(length(grep("worst",num,fixed = TRUE)))
        num<- nrow(dat)

      #If the rank passed by param is greater then # of rows
      #it means this rank does not exists in this state
      if(num>nrow(dat))
      {
        name<-c(NA)
        state<-dat[1,2]
        result<-data.frame(Name=name,State=state)
        return (result)
      }

      return(dat[num,1:2])
  }
  
  ##Load a array with the outcomes names  
  outcomes <- c("heart attack","pneumonia","heart failure")
  
  ##Check whether the outcome passed through params is valid
  if(!(outcome %in% outcomes)) stop("invalid outcome")   
  
  ## Read outcome data
  hospitals <- read.csv(paste(getwd(),"outcome-of-care-measures.csv",sep="/"), colClasses = "character",na.strings="Not Available")
  
  ##selects the columns of interest
  hospitals<-hospitals[,c(2,7,11,17,23)]
  
  ##Rename the columns
  colnames(hospitals)<-c("Name","State","heart.attack","heart.failure","pneumonia")
  
  ##Replaces the spaces in the outcomes once it was checked
  outcome<-sub(" ",outcome,fixed = TRUE,replacement = ".")
 
  ##Select the outcome of interest
  hospitals<- hospitals[,c("Name","State",outcome)]
  
   #split the data set by states
  hospitals<-split(hospitals,hospitals$State)
  
  ##Get the dataset inside the list
  hospitals<- lapply(hospitals, sortByState,outcome=outcome)

  rank<- lapply(hospitals, rankByState,num=num)
  rank<-Reduce(function(x, y) merge(x, y, all=TRUE,sort=FALSE), rank)
  return(rank)
}