
# Created using R version 4.0.0 on Windows 10 64-bit edition.
# This version of the package 'dplyr' used was 1.4.4.
# See README.md for more details.


library(dplyr)

#--------------------------------------------------------------------------------
#Getting the data
#--------------------------------------------------------------------------------


# download file containing data:
if (!file.exists("UCI HAR Dataset.zip")) {
  message("Data download - starting. This may take a while...")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,"UCI HAR Dataset.zip", mode = "wb")
  message("Data download - done")
} else {
  message(paste("Data  download - already downloaded.", sep=""))
}

# unzip the zip file containing the data
filename <- "UCI HAR Dataset.zip"

dataPath <- "UCI HAR Dataset"

if (!file.exists(dataPath)) {
  unzip(filename)
  message("Data unzip - done")
} 


message(paste("Reading the data. This may take a while...", sep=""))

#-------------------------------------------------------------------------------
#Reading the features names and appropriately it with descriptive variable names
#-------------------------------------------------------------------------------

# read features
features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("id","features_names"))

features$features_names <- gsub('[-()]', '', features$features_names)
features$features_names <- gsub('-mean', 'Mean', features$features_names)
features$features_names <- gsub('-std', 'Std', features$features_names)
features$features_names <- gsub('[-()]', '', features$features_names)
features$features_names <- gsub("BodyBody", "Body", features$features_names)
features$features_names <- gsub("^f", "frequencyDomain", features$features_names)
features$features_names <- gsub("^t", "time", features$features_names)

#-----------------------------------------------------------------------------
#Reading the data
#-----------------------------------------------------------------------------

# read activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("label", "activity"))

# read the train data tables
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt", 
                              col.names = "label")
trainActivitiesLabel <- left_join(trainActivities, activities, by = "label")
trainValues <- read.table("UCI HAR Dataset/train/X_train.txt", 
                          col.names = features$features_names)


train <- cbind(trainSubjects, trainActivitiesLabel, trainValues)
train <- select(train, -label)
rm(trainSubjects, trainActivities,trainActivitiesLabel, trainValues)


# read the test data tables
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt", 
                             col.names = "label")
testActivitiesLabel <- left_join(testActivities, activities, by = "label")
testValues <- read.table("UCI HAR Dataset/test/X_test.txt", 
                         col.names = features$features_names)

# concatenate the test data tables
test <- cbind(testSubjects, testActivitiesLabel, testValues)
test <- select(test, -label)
rm(testSubjects, testActivities,testActivitiesLabel, testValues)


# concatenate the test and train data tables to a single data table
completeData <- rbind(test,train)

message(paste("Creating the tiny data...", sep=""))


#-----------------------------------------------------------------------------
# Extracting only the data on mean and standard deviation for each measurement
#-----------------------------------------------------------------------------

tidyDataMeanStd <- select(completeData, contains("Mean"), contains("Std"))
tidyDataMeanStd <- select(tidyDataMeanStd, -contains("angle"))

#-----------------------------------------------------------------------------
# Turning activities & subjects into factors
#-----------------------------------------------------------------------------

# Averanging all variable by each subject each activity
tidyDataMeanStd$subject <- as.factor(completeData$subject)
tidyDataMeanStd$activity <- as.factor(completeData$activity)

#----------------------------------------------------------------------------
# Creating an tidy dataset with the average of each variable for each 
#  activity and each subject
#----------------------------------------------------------------------------

tidyAvg <- tidyDataMeanStd %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

write.table(tidyAvg, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)

write.csv(tidyDataMeanStd,"DataMeanStd")

message(paste("Tiny data successfully created as 'tiny_data.txt'.", sep=""))