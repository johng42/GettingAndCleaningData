Codebook for Getting And Cleaning Data Course Project

How the code works:
This source file takes data from this web site: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
and processes it into a tidy data set as defined by John Hopkins Getting and Cleaning Data class:
https://class.coursera.org/getdata-007
The full data set used was downloaded on 9/3/2014 from ...
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and may have changed by the time you read this.

Machine information: 
Windows 8.1

R Version 3.1.0 "Spring Dance"

32 bit

The code reads the text file data for the test and training sets.  It merges the two sets and sets appropriate column names.  Per class notes, a "tidy" data file is created with standard deviation and mean for each activity and participant in the study.

Variable names:
The training and test sets for x and y are stored in "trainx", "testy", etc...  The subjects are stored in "testsub" and "trainsub".

The 561 features are stored in "features".

The assignment calls for the test and train data sets to be merged.  This concatenation is done with "testbounddata" and "trainbounddata" and the combined data is stored in a simply named "data" variable.

The GREP command to extract the columns needed for mean and standard deviation is a bit complicated.  The command is this:

dataset1<-data[,c(1,2 ,grep(".*-std.*",colnames(data)), grep(".*-Std.*", colnames(data)),grep(".*-Mean.*", colnames(data)), grep(".*-mean.*", colnames(data)))]


There is a good explanation of this here: http://www.regular-expressions.info/rlanguage.html  but the point is to select the columns with variants of "std" for standard deviation and "mean" in them for creating the final data set.

The reshape2 library is used for melting and dcasting the data.
Hadley Wickham (2007). Reshaping Data with the reshape Package. Journal of Statistical Software, 21(12), 1-20. URL http://www.jstatsoft.org/v21/i12/. 

The code takes the full data set and sets the column names for the six exercises from the study.  There is some optional code to save a data set mentioned in the exercise but is not actually needed to be saved.  You can uncomment that line if you want the extra dataset.  

Finally, all the columns except the name of the specific exercise are extraces and melted into a data frame with the reshape2 melt command.  The means (averages) for each column are computed and written to "FinalDataSet.csv" in CSV format.



