## script for course project
## set the working directory to the downloaded data set after unzip
setwd("D:/coursera/getting and cleanning data/project/UCI HAR Dataset")

## read the files and give them colnames
subject_train <- read.table("./train/subject_train.txt")
ytrain <- read.table("./train/y_train.txt")
features <- read.table("features.txt")
trainset <- read.table("./train/X_train.txt", col.names = features[,2])
library(dplyr)
trainset2 <- mutate(trainset, actcode = ytrain[,1], 
                    subject_id = subject_train[,1])
testset <- read.table("./test/X_test.txt", col.names = features[,2])
ytest <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
testset2 <- mutate(testset, actcode = ytest[,1], 
                    subject_id = subject_test[,1])

## Merges the training and the test sets to create one data set.
mergeds <- rbind(trainset2,testset2)

## Extracts only the measurements on the mean and standard deviation 
##  for each measurement. 
library(stringr)
colinx1 <- str_detect(features$V2,"mean()")
colinx2 <- str_detect(features$V2,"std()")
colinx <- colinx1 | colinx2
colindex <- features[colinx,1]
extract_ds <- mergeds[,colindex]

## Uses descriptive activity names to name the activities in the data set
actlabel <- read.table("activity_labels.txt")
mergeds2 <- merge(mergeds, actlabel, by.x="actcode", by.y="V1", all=TRUE)

## Appropriately labels the data set with descriptive variable names.
## Meaningful colnames are already given at the first step 
##   using features.txt file
mergeds2 <- rename(mergeds2, activity=V2)
mergeds2 <- select(mergeds2, -actcode)

## From the data set in step 4, creates a second, independent tidy data set 
##   with the average of each variable for each activity and each subject
newds1 <- group_by(mergeds2, subject_id, activity)
newds <- summarise_each(newds1,funs(mean))
write.table(newds, file="cleands.txt", row.names=FALSE)
