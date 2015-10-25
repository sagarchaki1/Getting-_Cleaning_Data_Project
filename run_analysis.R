# Clean up workspace
rm(list=ls())

# STEP 1. Merge the training and the test sets to create one final dataset.

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd("~/Nandini/Coursera/Specialization_Data Science/3.Getting and Cleaning data");


## Read labels and features
features <- read.table('./UCI HAR Dataset/features.txt',header=FALSE); #imports features.txt
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE); #imports activity_labels.txt

colnames(activity_labels)  = c('activity_id','activity_name');

# Read in the test data from downloaded files
x_test <- read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE); 
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE); 

subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE); 
#imports subject_test.txt

## Checking the top rows of each of the datasets using head() function 
head(x_test)
head(y_test)
head(subject_test)

## Renaming the columns(test data)
colnames(x_test) <- features[,2]
colnames(y_test) <- "activity_id"
colnames(subject_test) <- "subject_id"

##Creating the test data
test_data <- cbind(subject_test,y_test, x_test);



# Read in the training data from downloaded files
x_train <- read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE); 
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE); 

subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE); #imports subject_train.txt



## Checking the top rows/names of each of the datasets using head() function 
head(x_train)
head(y_train)
head(features)
head(activity_labels)
head(subject_train)


## Renaming the Columns
colnames(x_train)        = features[,2]; 
colnames(y_train)        = "activityId";
colnames(subject_train)  = "subject_id";

## creating the Training set 
train_data <- cbind(subject_train,y_train,x_train)
head(train_data) #Check


## Appending the test and the train datasets 
names(test_data) #Check
names(train_data) #Check

whole_data <- rbind(test_data)



## Step 2: Selecting columns with mean and std measurements
library(gdata)
names(whole_data) #Check

# selcting the columns first
select_cols <- matchcols(whole_data, with=c("activity", "subject", "mean","std"), method="or")

# converting the list to a vector in details
s1<- select_cols[[1]]
s2<- select_cols[[2]]
s3<- select_cols[[3]]
s4<- select_cols[[4]]

#select_cols1 <- c(s1,s2,s3,s4) #Check


# Subsetting the data based on the selected mean, std columns

data1 <- whole_data[,c(s1,s2,s3,s4)]
names(data1) #Check


##Step 3: Using descriptive activity names to name the activities in the data set
# 1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING5 STANDING6 LAYING

data1$activity_name <- ifelse(data1$activity_id==1,"WALKING",
                              ifelse(data1$activity_id==2,"WALKING_UPSTAIRS",
                                     ifelse(data1$activity_id==3,"WALKING_DOWNSTAIRS",
                                            ifelse(data1$activity_id==4,"SITTING",
                                                   ifelse(data1$activity_id==5,"STANDING","LAYING")))))
                                                        
head(data1[data1$activity_id == 4,]) #Check
head(data1[data1$activity_id == 2,]) #Check


##Step4 : Appropriately labels the data set with descriptive variable names using gsub
names(data1) #Check

var_names = colnames(data1); 

for (i in 1:length(var_names)) 
{
  var_names[i] = gsub("-mean","Mean",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("([Gg]ravity)","Gravity",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("\\()","",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("-std$","StdDev",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("-std","StdDev",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("[Gg]yro","Gyro",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("^(t)","time",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("JerkMag","JerkMagnitude",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("^(f)","freq",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("AccMag","AccMagnitude",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("GyroMag","GyroMagnitude",var_names[i],ignore.case = TRUE)
  var_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",var_names[i],ignore.case = TRUE)
};

colnames(data1) = var_names;
names(data1) #Check

#Re-arranging the column names as the final tidy dataset
tidy_data  <- data1[,c(1:2,82,3:81)]

head(tidy_data) #Check

write.table(tidy_data, "./UCI HAR Dataset/tidy_data.txt", row.name=FALSE)

##Step 5: Creates a second, independent 
   #tidy data set with the average of each variable for each activity and each subject.

library(plyr)
avg_data <- ddply(tidy_data, .(activity_name,subject_id), function(x) colMeans(x[, 4:82]))

head(avg_data) #Check

write.table(avg_data, "./UCI HAR Dataset/averages_data.txt", row.name=FALSE)
