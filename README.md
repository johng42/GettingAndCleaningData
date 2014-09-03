Getting And Cleaning Data Course Project

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

The reshape2 library is used for melting and dcasting the data.
Hadley Wickham (2007). Reshaping Data with the reshape Package. Journal of Statistical Software, 21(12), 1-20. URL http://www.jstatsoft.org/v21/i12/. 



