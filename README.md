
##Getting-_Cleaning_Data_Project: ReadME.md

> Initial steps to clean up workspace and set up the working directory

### STEP 1. Merge the training and the test sets to create one final dataset.

> Reading activity labels and features 
> Reading test and training datasets and rename appropriate colnames 

> Using cbind function to merge subject,x and y data for test and training datasets.(two diferent sets)

> Checking the top rows/names of each of the datasets using head() function 
> Renaming the Columns

> Appending the test and the train datasets to create the whole_data 



### Step 2: Selecting columns with mean and std measurements
selcting columns with the std dev or mean measures using matchcols function 

converting the list to a vector in details
Subsetting the data based on the selected mean, std columns



Step 3: Using descriptive activity names to name the activities in the data set based on activity labels
1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING5 STANDING6 LAYING

Step4 : Appropriately labels the data set with descriptive variable names using gsub , get the final tidy dataset
tidy_data

Create a vector with column names 
Rename the column names with descriptive understanding using gsub() function , ignoring CASE
Put back the defined column names back to the dataset
  
Re-arranging the column names as the final tidy dataset
write the final tidy dataset into txt format tidy_data


Step 5: Creates a second, independent 
   tidy data set with the average of each variable for each activity and each subject.

plyr package
 using ddply() function on activity_name and subject_id

write the avg dataset into txt format avg_data
