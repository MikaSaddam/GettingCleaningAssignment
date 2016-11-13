
    library(dplyr)
  
  ## Read datasets,combine & check the file exist or not
  if (!file.exists("UCI HAR Dataset")) 
  { 
    stop("Data folder not found!")
  }
  
  ## Get the test data, labels & subjects and combine all 
  testData <- read.table("UCI HAR Dataset/test/X_test.txt")
  testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
  colnames(testActivities) <- c("activity")
  
  ## Perform Task
  testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
  colnames(testSubjects) <- c("subject")
  observationType <- rep_len("test", nrow(testData))
  testData <- cbind(observationType, testSubjects, testActivities, testData)
  
  ## Get the train data, labels & subjects and combine all
  trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
  trainActvities <- read.table("UCI HAR Dataset/train/y_train.txt")
  colnames(trainActvities) <- c("activity")
  
  ## Perform Task
  
  trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
  colnames(trainSubjects) <- c("subject")
  observationType <- rep_len("train", nrow(trainData))
  trainData <- cbind(observationType, trainSubjects, trainActvities, trainData)
  
  ## Combine the both test and train data:
  combineData <- rbind(testData, trainData)
  
  ## Get the column names avaiable in the data:
  features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
  columnNames <- features$V2
  
  ## Perform std and mean task in columns
  stdmeanColumns <- grepl("(std|mean[^F])", columnNames, perl=TRUE)
  
  ## Clean the data required to be use 
  combineData <- combineData[, c(TRUE, TRUE, TRUE, stdmeanColumns)]
  
  names(combineData) <- c("ObservationType","Subject","Activity",
                         columnNames[stdmeanColumns])
  names(combineData) <- gsub("\\(|\\)", "", names(combineData))
  names(combineData) <- tolower(names(combineData))
  
  ## Get the activity_labels data from the dataset
  activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  combineData = merge(combineData,activityLabels,by.x="activity",by.y="V1",all=TRUE)    
  combineData$activity = combineData$V2
  combineData <- combineData[ , !(names(combineData) %in% c("V2"))]
  
  ## Perform the clean data set - combineData
  
  ## Write clean data to csv:
  
  write.csv(combineData, file="combineData.txt", row.names = FALSE)
  
  ## Perform average calculation to the each variable in the dataset
  
  combineData <- combineData[ , !(names(combineData) %in% c("observationtype"))]
  
  cleanData <- combineData %>% 
    group_by(activity, subject) %>% 
    summarise_each(funs(mean))
  
  ## Write to output:
  write.table(cleanData, file="CleanData.txt", row.names = FALSE)



