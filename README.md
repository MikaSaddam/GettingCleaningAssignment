# Peer-graded Assignment: Getting and Cleaning Data Course Project

The assignment project is about writing an R script (`run_analysis.R`) that fulfills the following tasks:

* Check either the data exist in the folder or not
* Combine the data set.
* Extracts the require then perform mean and standard deviation the data
* Get about activity names to name the activities in the data set
* Give labels the data set with descriptive variable names.
* Creates another and independent tidy data set with the average of each variable for each activity and each subject.

The data to be processed was collected from smartphones.

* Downloads and unzips the zipped data before run the script

The script `run_analysis.R` will perform as below:

* Reads the datasets variable  `observationType`, `testSubjects`, `testActivities`, `testData`
* Combine all the datasets variable needed 
* Reads dataset "Features" and extracts only the variables for mean and standard deviation for each measurement
* Perform subsetting and updates on testData, trainData
* Combine all the updated datasets  variable needed 
* Generates output ASCII file (CleanData.txt) 
