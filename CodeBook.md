### Introduction

CodeBook.md - this is the codebook for the run_analysis.R script.
It describes the variables, the data, and any transformations that are performed to clean up the data.

###Source of Data

Data was obtained from the following site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The files were downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###Data cleansing steps

1. From all the set, only the train and test data set is used. 
train/X_train.txt
test/X_test.txt

2. The data is  combined using the cbind R function.

3. Only the data pertaining to mean and standard deviation is extracted from the files.
This is done by using grep R function.

3. 2 additional columns called subject and activity are also added.
The subject column is for the people who participated in the exercise. 
This is from subject_test.txt file and subject_train.txt file from the test and train folders.

The activity column lists all the activities done while collecting the. This is from the Y_test.txt
and Y_train.txt files. 

4. Next the merge function is used to lookup activity codes from activity_labels.txt file.

5. The variable names are all cleaned up by eliminating "-" and "_".

6. THe average of each of the colums is then calculated by activity and subject and written to a file. This is the tiny dataset.



