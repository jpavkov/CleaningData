# TODO: Add comment
# 
# Author: pavkoj1
###############################################################################


#	You should create one R script called run_analysis.R that does the following: 
#	1. Merges the training and the test sets to create one data set.
#	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#	3. Uses descriptive activity names to name the activities in the data set
#	4. Appropriately labels the data set with descriptive variable names. 
#	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



########### SETUP ENV ##########
# libraries
library(data.table)
library(reshape2)

# set working directory
wd <- setwd("C:/devl/Coursera/03 Getting and Cleaning Data/data")



########### ACQUIRE DATA ##########
# test
subject_test <- data.table(read.table("subject_test.txt"))
setnames(subject_test,"V1","subject")

y_test <- data.table(read.table("y_test.txt"))
setnames(y_test,"V1","test")
y_test[test==1,test_ds:="WALKING"]
y_test[test==2,test_ds:="WALKING_UPSTAIRS"]
y_test[test==3,test_ds:="WALKING_DOWNSTAIRS"]
y_test[test==4,test_ds:="SITTING"]
y_test[test==5,test_ds:="STANDING"]
y_test[test==6,test_ds:="LAYING"]
y_test[,metric:=""]

x_test <- data.table(read.table("X_test.txt"))


# train
subject_train <- data.table(read.table("subject_train.txt"))
setnames(subject_train,"V1","subject")

y_train <- data.table(read.table("y_train.txt"))
setnames(y_train,"V1","test")
y_train[test==1,test_ds:="WALKING"]
y_train[test==2,test_ds:="WALKING_UPSTAIRS"]
y_train[test==3,test_ds:="WALKING_DOWNSTAIRS"]
y_train[test==4,test_ds:="SITTING"]
y_train[test==5,test_ds:="STANDING"]
y_train[test==6,test_ds:="LAYING"]
y_train[,metric:=""]

x_train <- data.table(read.table("X_train.txt"))


########### Step 1 ##########
#	1. Merges the training and the test sets to create one data set.

test <- cbind(subject_test, y_test, x_test)
train <- cbind(subject_train, y_train, x_train)
combined <- rbind(test,train)



########### Step 4 ##########
#	4. Appropriately labels the data set with descriptive variable names.
features <- data.table(read.table("features.txt"))
setnames(combined,5:565,as.character(features[,V2]))



########### Step 2 ##########
#	2. Extracts only the measurements on the mean and standard deviation for each measurement.
features.char <- as.character(features[,V2])
str(features.char)
matched.mean <- grep("mean()", features.char)
matched.std <- grep("std()", features.char)
matched.both <- c(matched.mean, matched.std)
other.names <- c("subject","test_ds","metric")
names.final <- c(other.names,features.char[matched.both])

combined <- combined[,names.final,with=FALSE]



########### Step 3 ##########
#	3. Uses descriptive activity names to name the activities in the data set
# completed in the acquire data step above



########### Step 5 ##########
#	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
combined.mean <- combined[, c(mean = lapply(.SD, mean)), by=c("subject","test_ds","metric")]
combined.mean[,metric:="mean"]
combined.sd <- combined[, c(sd = lapply(.SD, sd)), by=c("subject","test_ds","metric")]
combined.sd[,metric:="sd"]
final <- rbind(combined.mean,combined.sd)

final.mean <- melt(combined.mean, id.vars=c("subject","test_ds","metric"))


write.table(final.mean,paste(wd,"tidy.txt",sep="/"),row.names=FALSE)














