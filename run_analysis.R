library(plyr)

## Downloading dataset

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip dataSet 
unzip(zipfile="./data/Dataset.zip",exdir="./data")


## A. Read "Training" and "Testing" datasets from downloaded location. Assigning names to each column datasets and finally merge
## "Training" and "Testing"st sets to create one data set:


## A.1 Reading "Training" tables:

Train_x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Train_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
Sub_Train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## A.2 Reading "Testing" tables:
Test_x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
Sub_Test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## A.3 Reading "Features" file:
features <- read.table('./data/UCI HAR Dataset/features.txt')

## A.4 Reading "Activity_labels" file:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

## A.5 Assigning column names:
colnames(Train_x) <- features[,2] 
colnames(Train_y) <-"activityId"
colnames(Sub_Train) <- "subjectId"

colnames(Test_x) <- features[,2] 
colnames(Test_y ) <- "activityId"
colnames(Sub_Test ) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

## A.6 Merging all data in one set:
merge_train <- cbind(Train_x, Sub_Train, Train_y )
merge_test <- cbind(Test_x, Sub_Test, Test_y)
merge_ALL <-  rbind(merge_train, merge_test)

# B. Extracting only the measurements on the mean and standard deviation for each measurement

# B.1 Reading column names:
colNames <-colnames(merge_All)

# B.2 Create vector for defining ID, mean and standard deviation:
mean_ID_std <-     (grepl("activityId" , colNames) | 
                    grepl("subjectId" ,  colNames) | 
                    grepl("mean.." ,     colNames) | 
                    grepl("std.." ,      colNames) )

# B.3 Subset from merge_all:
Mean_Std_Final <- merge_All[ , mean_ID_std == TRUE]


# C. Using descriptive activity names to name the activities in the data set:

ActivityNames <- merge (Mean_Std_Final, activityLabels, by = 'activityId', all.x= TRUE)


# D. Appropriately labeling the data set with descriptive variable names.

# D.1 - labelling "Features"
features <- read.table('./data/UCI HAR Dataset/features.txt')

#D.2 - labelling "Mean and St.dev of ActivityID, SubjectID"

mean_std <-     (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) )

#D.3 - labelling subset of Grand Mean and St.dev

Mean_Std_Final <- merge_all[ , mean_std == TRUE]



# E. Creating a second, independent tidy data set with the average of each 
#   variable for each activity and each subject:

# E.1 Making second tidy data set 

TidySet <- aggregate(. ~ subjectId + activityId, ActivityNames, mean)
TidySet <- TidySet[order(TidySet$subjectId, TidySet$activityId), ]


# E.2 Writing second tidy data set in txt file

write.table(TidySet, "2ndTidySet.txt", row.name=FALSE)


