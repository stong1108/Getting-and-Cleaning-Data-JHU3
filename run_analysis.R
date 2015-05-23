## Coursera- Getting & Cleaning Data Course Project

require(dplyr)

## TASK 1: MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
## ------------------------------------------------------------------------
testSubj <- read.table("./test/subject_test.txt")
xTest <- read.table("./test/X_test.txt")
yTest <- read.table("./test/y_test.txt")
testData <- cbind(testSubj, yTest, xTest)

trainSubj <- read.table("./train/subject_train.txt")
xTrain <- read.table("./train/X_train.txt")
yTrain <- read.table("./train/y_train.txt")
trainData <- cbind(trainSubj, yTrain, xTrain)

data <- rbind(testData, trainData)

## TASK 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
## FOR EACH MEASUREMENT
## ------------------------------------------------------------------------
## Determine indices of mean & std data given by "features.txt"
features <- read.table("features.txt")
meanIndices <- grep("mean()", features[,2], fixed = TRUE)
stdIndices <- grep("std()", features[,2], fixed = TRUE)
desiredIndices <- sort(c(meanIndices, stdIndices))

## Shift indices by 2 since subject ID and activity were added to the left in
## the merged data set
desiredIndices <- desiredIndices + 2

## Modify data to only subject ID, activity, and mean & std (from desiredIndices)
data <- data[, c(1, 2, desiredIndices)]

## TASK 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
## ------------------------------------------------------------------------
labels <- read.table("activity_labels.txt")
for (i in 1:nrow(labels)) {data[,2] <- gsub(labels[i,1], labels[i,2], data[,2])}

## TASK 4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
## ------------------------------------------------------------------------
varnames <- c("t_meanAccX", "t_meanAccY", "t_meanAccZ", "t_stdAccX", "t_stdAccY", "t_stdAccZ",
              "t_meanGravAccX", "t_meanGravAccY", "t_meanGravAccZ", "t_stdGravAccX", "t_stdGravAccY", "t_stdGravAccZ", 
              "t_meanJerkX", "t_meanJerkY", "t_meanJerkZ", "t_stdJerkX", "t_stdJerkY", "t_stdJerkZ",
              "t_meanGyroX", "t_meanGyroY", "t_meanGyroZ", "t_stdGyroX", "t_stdGyroY", "t_stdGyrozZ",
              "t_meanGyroJerkX", "t_meanGyroJerkY", "t_meanGyroJerkZ", "t_stdGyroJerkX", "t_stdGyroJerkY", "t_stdGyroJerkZ",
              "t_meanAcc", "t_stdAcc", "t_meanGravAcc", "t_stdGravAcc", "t_meanJerk", "t_stdJerk",
              "t_meanGyro", "t_stdGyro", "t_meanGyroJerk" ,"t_stdGyroJerk",
              "f_meanAccX", "f_meanAccY", "f_meanAccZ", "f_stdAccX", "f_stdAccY", "f_stdAccZ",
              "f_meanJerkX", "f_meanJerkY", "f_meanJerkZ", "f_stdJerkX", "f_stdJerkY", "f_stdJerkZ",
              "f_meanGyroX", "f_meanGyroY", "f_meanGyroZ", "f_stdGyroX", "f_stdGyroY", "f_stdGyroZ",
              "f_meanAcc", "f_stdAcc", "f_meanJerk", "f_stdJerk", "f_meanGyro", "f_stdGyro", "f_meanGyroJerk", "f_stdGyroJerk")
names(data) <- c("id", "act", varnames)

## TASK 5: CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH
## VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
## ------------------------------------------------------------------------
## Group data by subject & activity
by_id_act <- group_by(data, id, act)

## Average each measurement and save into new data frame
groupedAvg <- summarise_each(by_id_act, funs(mean))
write.table(groupedAvg, "GroupedAvg.txt", row.names = FALSE)
