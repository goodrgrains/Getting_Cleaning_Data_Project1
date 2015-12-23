# Coursera - JHU Class Getting and Cleaning Data
# Course Projet Number 1
# This R script reads in accelerometer data from the UCS Handset Dateset
# and creates a subset of data that is 
# output to a txt file.

library(dplyr)

#Read in the data from work directory
x_test_data<-read.table("X_test.txt")
y_test_data<-read.table("y_test.txt")
subject_test_data<- read.table("subject_test.txt")
subject_train_data<- read.table("subject_train.txt")
y_train_data<-read.table("y_train.txt")
x_train_data<-read.table("X_train.txt")

#Combine the data
test_data<-cbind(subject_test_data, y_test_data, x_test_data)
train_data<-cbind(subject_train_data, y_train_data, x_train_data)
big_data<- rbind(test_data, train_data)

#Add Column labels from the 'features.txt' file 
labels<-read.table("E:\\data\\UCI HAR Dataset\\features.txt")

labels[,2]<-as.character(labels[,2])

labels[1]=NULL
labels<-rbind("Activity", labels)
labels<-rbind("Subject", labels)

colnames(big_data)<-labels[,1]

#Extract all columns that are 'mean' or 'std'
data_mean<-big_data[, grep("mean",colnames(big_data))]
data_std<-big_data[ , grep("std", colnames(big_data))]
t_data<-cbind(big_data[,1], big_data[,2], data_mean[,], data_std[,])
colnames(t_data)[1]<-"Subject"
colnames(t_data)[2]<-"Activity"

#Relabel the 'Activity' column with descriptive names
t_data$Activity[t_data$Activity==1]<-"Walking"
t_data$Activity[t_data$Activity==2]<- "Walking_Upstairs"
t_data$Activity[t_data$Activity==3]<- "Walking_Downstairs"
t_data$Activity[t_data$Activity==4]<- "Sitting"
t_data$Activity[t_data$Activity==5]<- "Standing"
t_data$Activity[t_data$Activity==6]<- "Laying"

#Order the data by Activity and Subject
g_data<- t_data[order(t_data[,1], t_data[,2]),]

#Output to 'g' a mean of each measurement column per Subject and Activity.
g<-aggregate(.~Subject + Activity, data=g_data, FUN="mean")

# Relabeled measurement column names with prefix - 'Mean'
colnames(g)<-paste("Mean", colnames(g), sep="-")

# Had to re-relabel the 'Subject' and 'Activity' to not have the 'Mean' prefix.
colnames(g)[colnames(g)=="Mean-Subject"]<-"Subject"
colnames(g)[colnames(g)=="Mean-Activity"]<-"Activity"

#Write Subsetted Data to txt file
write.table(g, file="GCD_Project1.txt", row.names=FALSE)