rankhospital <- function(st, outcome,num) {
  
  ##Load dataset of all US States (R built-on)
  data(state)
  
  ##Load a array with the outcomes names  
  outcomes <- c("heart attack","pneumonia","heart failure")
  
  ##Check whether the state passed through params is valid
  if(!(st %in% state.abb)) stop("invalid state")
  
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
  #split the data set by states
  hospitals<-split(hospitals,hospitals$State)
  
  ##get the state of interest
  hospitals<- hospitals[st]
  
 
  ##Get the dataset inside the list
  hospitals<- hospitals[[1]]
  
  
  ##Select the outcome of interest
  hospitals<- hospitals[,c("Name",outcome)]
  
  ##sorted<-hospitals[sort(hospitals[,"Name"]),as.numeric(hospitals[,outcome]),decreasing=FALSE,na.last = NA)]
  hospitals<-hospitals[order(as.numeric(hospitals[,outcome]),hospitals[,"Name"],na.last = NA,decreasing = FALSE),]
  
  
 
  #check if the num is a character and then assign the proprer values
  if(!is.numeric(num))
    if(length(grep("best",num,fixed = TRUE)))
      num<-1L
  else if(length(grep("worst",num,fixed = TRUE)))
    num<- nrow(hospitals)

  #If the rank passed by param is greater then # of rows
  #it means this rank does not exists in this state
  if(num>nrow(hospitals)) 
    NA
  return(hospitals[num,1])
}