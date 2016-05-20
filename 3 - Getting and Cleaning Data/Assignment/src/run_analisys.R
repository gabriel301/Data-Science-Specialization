run_analysis <- function(folder)
{
  message("Script Initialized")
  library(data.table)
  library(stringr)
  library(dplyr)
  library(tidyr)
  destinationFolder<-paste(folder,"Tidy Data",sep="/")
  #REGION 1 - READING FILES
  if(!file.exists(folder))
  {
    stop("Could not open the folder. Please check the directory and try again")
  }
  activityFile <- paste(folder,"activity_labels.txt",sep="/")
  if (!file.exists(activityFile))
  {
    stop("Could not find the activity_labels file")
  }
  
  featureFile <- paste(folder,"features.txt",sep="/")
  if (!file.exists(featureFile))
  {
    stop("Could not find the features file")
  }
  
  
  testFileX <-  paste(folder,paste("test","X_test.txt",sep="/"),sep="/")
  if (!file.exists(testFileX))
  {
    stop("Could not find the folder containing the test files")
  }
  
  
  testFileY <-  paste(folder,paste("test","y_test.txt",sep="/"),sep="/")
  if (!file.exists(testFileY))
  {
    stop("Could not find the folder containing the test files")
  }
 
  
  subjectTestFile <-  paste(folder,paste("test","subject_test.txt",sep="/"),sep="/")
  if (!file.exists(subjectTestFile))
  {
    stop("Could not find the folder containing the training files")
  }
  
  trainFileX <-  paste(folder,paste("train","X_train.txt",sep="/"),sep="/")
  if (!file.exists(trainFileX))
  {
    stop("Could not find the folder containing the training files")
  }
  
  subjectTrainFile <-  paste(folder,paste("train","subject_train.txt",sep="/"),sep="/")
  if (!file.exists(subjectTrainFile))
  {
    stop("Could not find the folder containing the training files")
  }
  
  trainFileY <-  paste(folder,paste("train","y_train.txt",sep="/"),sep="/")
  if (!file.exists(trainFileY))
  {
    stop("Could not find the folder containing the training files")
  }

  subjectTrain<- fread(subjectTrainFile,data.table = TRUE,col.names = "Subject")
  message(paste("File Loaded:",subjectTrainFile,sep=" "))
  
  subjectTest<- fread(subjectTestFile,data.table = TRUE,col.names = "Subject")
  message(paste("File Loaded:",subjectTestFile,sep=" "))
  
  activityNames<- fread(activityFile,data.table = TRUE,col.names = c("id","Activity"))
  message(paste("File Loaded:",activityFile,sep=" "))
  
  featuresNames<- fread(featureFile,data.table = TRUE) #get the features' names
  message(paste("File Loaded:",featureFile,sep=" "))
  
  yTrain <- fread(trainFileY,data.table = TRUE,col.names = "id")
  message(paste("File Loaded:",trainFileY,sep=" "))
  
  yTest <- fread(testFileY,data.table = TRUE,col.names = "id")
  message(paste("File Loaded:",testFileY,sep=" "))
  
  #Load both train and test sets with the columns' names
  xTrain <- fread(trainFileX,col.names = as.vector(featuresNames$V2),data.table = TRUE)
  message(paste("File Loaded:",trainFileX,sep=" "))
  
  xTest <- fread(testFileX,col.names = as.vector(featuresNames$V2),data.table = TRUE)
  message(paste("File Loaded:",testFileX,sep=" "))
  
  rm(folder,subjectTrainFile,subjectTestFile,activityFile,featureFile,trainFileY,testFileY,trainFileX,testFileX)
  
  #END REGION 1
  
  #REGION 2 - MERGE TRAIN AND TEST DATASETS
  
  message("Merging train and test datasets...")
  mergedDataSet <- rbind(xTrain,xTest)
  subjectsMerged<- rbind(subjectTrain,subjectTest)
  mergedLabels <- rbind(yTrain,yTest)
  message("Merge Done Successfully.")
  rm(xTrain,xTest,subjectTrain,subjectTest,yTrain,yTest)
  #END REGION 2
  
  #REGION 3 - SELECT ONLY MEAN AND STD FEATURES
  message("Selecting features of interest...")
  selectedFeatures <- grep("mean\\(|std\\(",featuresNames$V2)
  mergedDataSet <- mergedDataSet[,selectedFeatures,with=FALSE]
  message("Feature Selection Done Successfully. ")
  rm(featuresNames)
  #END REGION 3
  
  #REGION 4 - USES DESCRIPTIVE ACTIVITY NAMES
   message("Attaching Activities' names into the Dataframe...")
   mergedLabels$rowId<- 1:nrow(mergedLabels) #rowId to track the order of rows
   mergedActivityNames<-inner_join(mergedLabels,activityNames,by="id") #join the names and Ids
   mergedActivityNames<-mergedActivityNames[order(mergedActivityNames$rowId),] #reorder the rows to the original order
   mergedDataSet<-cbind(mergedActivityNames$Activity,mergedDataSet)
   colnames(mergedDataSet)[1] <- "Activity"
   mergedDataSet<-cbind.data.frame(subjectsMerged,mergedDataSet) #Attaches the subject column
   message("Activities' names attached successfully.")
   rm(mergedLabels,mergedActivityNames,subjectsMerged)
   #END REGION 4
  
  #REGION 5 - Appropriately labels the data set with descriptive variable names
  message("Labelling the Dataset columns...")
  names<-colnames(mergedDataSet)[3:ncol(mergedDataSet)]
  names<-colnames(mergedDataSet)[3:ncol(mergedDataSet)]
  names<-sub("^t","Time.",names)
  names<-sub("^f","Frequency.",names)
  names<-sub("(body)+","Body.",names,ignore.case = TRUE)
  names<-sub("(gravity)+","Gravity.",names,ignore.case = TRUE)
  names<-sub("acc","Accelerometer.",names,ignore.case = TRUE)
  names<-sub("gyro","Gyroscope.",names,ignore.case = TRUE)
  names<-sub("mag","Magnitude.",names,ignore.case = TRUE)
  names<-sub("jerk","Jerk.",names,ignore.case = TRUE)
  names<-sub("mean()$","Mean",names,ignore.case = TRUE)
  names<-sub("std()$","StandardDeviation",names,ignore.case = TRUE)
  names<-sub("mean()","Mean.",names,ignore.case = TRUE)
  names<-sub("std()","StandardDeviation.",names,ignore.case = TRUE)
  names<-gsub("-","",names)
  names<-gsub("\\(\\)","",names)
  AjustedNamesMagnitudeIndex<-grep("Magnitude",names,ignore.case = TRUE)
  AjustedNamesJerkIndex<-grep("Jerk",names,ignore.case = TRUE)
  names[AjustedNamesMagnitudeIndex]<-sub("Magnitude.","",names[AjustedNamesMagnitudeIndex],ignore.case = TRUE)
  names[AjustedNamesJerkIndex]<-sub("Jerk.","",names[AjustedNamesJerkIndex],ignore.case = TRUE)
  names[AjustedNamesMagnitudeIndex]<-paste(names[AjustedNamesMagnitudeIndex],".Magnitude",sep="")
  names[AjustedNamesJerkIndex]<-paste(names[AjustedNamesJerkIndex],".NA.Jerk",sep="")
  names<-sub("(\\.\\.)",".NA.",names,ignore.case = TRUE)
  names<-sub("Magnitude.NA.Jerk","Magnitude.Jerk",names,ignore.case = TRUE)
  colnames(mergedDataSet)[3:ncol(mergedDataSet)] <- names
  
  message("Labelling done successfully.")
  rm(AjustedNamesJerkIndex,AjustedNamesMagnitudeIndex)
  #END REGION 5 
  
  #REGION 6 -Group data and calculate the Mean
  
  message("Grouping data and calculating the Average Values...")
  mergedDataSet<-melt(mergedDataSet,id.vars=c("Subject","Activity"),measure.vars=names)
  mergedDataSet<-aggregate(mergedDataSet$value,by=list(mergedDataSet$Subject,mergedDataSet$Activity,mergedDataSet$variable),FUN=mean)
  mergedDataSet<-separate(mergedDataSet,Group.3,c("Signal_Domain","Acceleration_Signal","Device","Measurement","Axis","Magnitude","Jerk"),fill = "right")
  mergedDataSet[mergedDataSet=="NA"] = NA
  colnames(mergedDataSet)[c(1,2,ncol(mergedDataSet))]<-c("Subject_ID","Activity","Average_Value")
  message("Data Grouped successfully.")
  rm(names)
  #END REGION 6
  
  #REGION 7 - wRITING DATA TO A FILE
  message("Writing the Tidy data into a file...")
  if(!dir.exists(destinationFolder))
  {
    dir.create(destinationFolder);
  }
  today<-format(Sys.Date(),format="%Y-%m-%d")
  now<-format(Sys.time(),format="%H-%M-%S")
  datetime<-paste(today,now,sep=" ") 
  filename<-paste(destinationFolder,"/Tidy-",datetime,".txt",sep="");
  write.table(mergedDataSet,file=filename,sep=" ",row.names= FALSE,col.names = TRUE,quote = FALSE)
  message(paste("File Created:",filename),sep=" ")
  message("Script Finished")
  rm(destinationFolder,today,now,filename,mergedDataSet)

}
