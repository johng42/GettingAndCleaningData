#This source file takes data from this location: 
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#and processes it into a tidy data set as defined by John Hopkins Getting and Cleaning Data class:
#https://class.coursera.org/getdata-007
#The full data set used was downloaded on 9/3/2014 from ...
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#this source file needs the reshape library (for melting and dcast)
library(reshape2)

#read all the data files
#they need to be in folders of the working folder, so extract the zip file above to that folder
#example: C:\Users\<<USERNAME>>\OneDrive\Documents\UCI HAR Dataset
testsub<-read.csv("test//subject_test.txt", header=FALSE, sep="")
testx<-read.csv("test//X_test.txt", header=FALSE, sep="")
testy<-read.csv("test//y_test.txt", header=FALSE, sep="")

trainsub<-read.csv("train//subject_train.txt", header=FALSE, sep="")
trainx<-read.csv("train//X_train.txt", header=FALSE, sep="")
trainy<-read.csv("train//y_train.txt", header=FALSE, sep="")


#set the  column names for the data (note the CAPS)
colnames(testsub)<-"PATIENT"
colnames(testy)<-"EXERCISE"
#the features file should be in the parent folder 
features <- read.table("features.txt")
feature_names <-  features[,2]
colnames(testx) <- feature_names

#repeat for training set
colnames(trainsub)<-"PATIENT"
colnames(trainy)<-"EXERCISE"
colnames(trainx)<-feature_names

#concatenate the training and test sets
testbounddata<-cbind(testsub, testy, testx)
trainbounddata<-cbind(trainsub, trainy, trainx)
data<-rbind(testbounddata, trainbounddata)

#get the columns for standard dev and mean - there are probably easier ways to do this
dataset1<-data[,c(1,2 ,grep(".*-std.*",colnames(data)), grep(".*-Std.*", colnames(data)),grep(".*-Mean.*", colnames(data)), grep(".*-mean.*", colnames(data)))]

#set the column names
dataset1$EXERCISE[dataset1$EXERCISE == 1] <- "WALKING"
dataset1$EXERCISE[dataset1$EXERCISE == 2] <- "WALKING_UPSTAIRS"
dataset1$EXERCISE[dataset1$EXERCISE == 3] <- "WALKING_DOWNSTAIRS"
dataset1$EXERCISE[dataset1$EXERCISE == 4] <- "SITTING"
dataset1$EXERCISE[dataset1$EXERCISE == 5] <- "STANDING"
dataset1$EXERCISE[dataset1$EXERCISE == 6] <- "LAYING"

#write the tidy dataset in CSV format, not needed for the class
#write.table(dataset1, "InitialDataSet.csv", row.names=FALSE, sep=',')

#Create a 2nd tidy dataset with the avg of each variable, for each activity, for each person
#Ignore the "EXERCISE" column - column2
measures<-dataset1[1,3:81]
measures<-colnames(measures)
datamelt<-melt(dataset1, id=c("PATIENT", "EXERCISE"), measure.vars=c(measures))
dataset2<-dcast(datamelt, PATIENT + EXERCISE ~variable,mean)
#write the data in CSV format
write.table(dataset2, "FinalDataSet.csv", row.names=FALSE, sep=',')
