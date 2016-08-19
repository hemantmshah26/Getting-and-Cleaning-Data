
CodeBook.md - A code book that describes the variables, the data

## A. Read "Training" and "Testing" datasets from downloaded location. Assigning names to each column datasets and finally merge
## "Training" and "Testing"st sets to create one data set:
## A.1 Reading "Training" tables
## A.2 Reading "Testing" tables:
## A.3 Reading "Features" file:
## A.4 Reading "Activity_labels" file:
## A.5 Assigning column names:
## A.6 Merging all data in one set:
## B. Extracting only the measurements on the mean and standard deviation for each measurement
## B.1 Reading column names:
## B.2 Create vector for defining ID, mean and standard deviation:
## B.3 Subset from merge_all:
## C. Using descriptive activity names to name the activities in the data set:
## D. Appropriately labeling the data set with descriptive variable names.
## D.1 - labelling "Features"
## D.2 - labelling "Mean and St.dev of ActivityID, SubjectID"
## D.3 - labelling subset of Grand Mean and St.dev
## E. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
## E.1 Making second tidy data set 
## E.2 Writing second tidy data set in txt file
