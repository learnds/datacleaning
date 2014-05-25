# programming assignment for Getting and cleaning Data 
#1.Merges the training and the test sets to create one data set.
# set working directory
setwd("~/")

# read training data 
train<-read.csv("./train/X_train.txt",sep="",header=FALSE)

# read training labels
label<-read.csv("features.txt",sep=" ",header=FALSE)

# read only the 2nd column
label_tran<-t(label[,2])

# Apply the column names from the labels tp the training data set
colnames(train)<-label_tran[1,]

#Next read the training subject and activity

train_sub<-read.csv("./train/subject_train.txt",sep="",col.names="subject")
train_act<-read.csv("./train/y_train.txt",col.names="activity")

# Merge all datasets above

train_w_sub<-cbind(train,train_sub)
train_sub_act<-cbind(train_w_sub,train_act)

# read test data set
test<-read.table("./test/X_test.txt",sep="",header=FALSE)

# apply the column names from labels obtained before
colnames(test)<-label_tran[1,]

# Read the test subject and activity files

test_sub<-read.csv("./test/subject_test.txt",sep="",col.names="subject")
test_act<-read.csv("./test/y_test.txt",sep="",col.names="activity")

# Merge all the test frames

test_w_sub<-cbind(test,test_sub)

test_sub_act<-cbind(test_w_sub,test_act)

dataset<-rbind(train_sub_act,test_sub_act)

  
#2.Extracts only the measurements on the mean and standard deviation for each measurement.

#filter data based on feature names using grep some pattern

filt_dataset<-dataset[,c(grep("mean\\(\\)|std\\(\\)|activity|subject",names(dataset)))]


#3.Uses descriptive activity names to name the activities in the data set

#replace 1,2,3 with activity_labels.txt
activity<-read.table("activity_labels.txt",col.names=c("activity","activity_name"))

#replace activity column with labels using merge statement

merge_dataset<-merge(filt_dataset,activity)

#4.Appropriately labels the data set with descriptive activity names. 
#clean up the labels using gsub by remove _,- and ()

cleanlabel1=gsub("\\(\\)","",names(merge_dataset))
cleanlabel2=gsub("-","",cleanlabel1)
cleanlabel3=gsub("_","",cleanlabel2)

# Apply the clean column names to the dataset
colnames(merge_dataset)<-cleanlabel3

# Creates a second, independent tidy data set with the average of each variable for 
# each activity and each subject. 

#create a data frame with avg values
# Move the subject and activity columns to first 2 columns

mds<-merge_dataset[,c(68:69,2:67)]

# this obtains average (mean) values for all numerical columns by subject and activity
final_dataset_avg<-aggregate(mds[,3:68],list(mds$subject,mds$activityname),mean)

# the aggregate function returns group 1 and group2 as the group by columns, rename them
colnames(final_dataset_avg)[1:2]=c("Subject","Activityname")

# create a final tiny dataset file from the data frame

write.table(final_dataset_avg,"tinydata.txt",sep=",")

