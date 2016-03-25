best <- function(st, outcome) {
  
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

  #Sort the Hospitals by Rate and then by name
  hospitals<-hospitals[order(as.numeric(hospitals[,outcome]),hospitals[,"Name"],na.last = NA,decreasing = FALSE),]
  #Return the name of the first hospital
  return(hospitals[1,1])
}