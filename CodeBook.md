###Getting and Cleaning Data Project : Code Book 


> Description

Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

A full description of the data used in this project can be found at The UCI Machine Learning Repository
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


> Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


> Attribute Information

For each observation we have :
    Activity label.
    Triaxial acceleration from the accelerometer (total acceleration)  estimated body acceleration.
    Triaxial Angular velocity from the gyroscope.
    A 561-feature vector with time and frequency domain variables.
    An identifier of the subject who carried out the experiment.


###Section 1. Merge the training and the test sets to create one data set.

After setting the source directory for the files, read into tables the data located into datasets (corresponding similar names)

    x_test
    y_test
    subject_test
    features
    activity_labels
    x_train
    y_train
     subject_train
  
Merging (x_test, y_test, subject_test) create test_data
Merging (x_train, y_train, subject_train) create train_data

Assign column names and merge test_data and train_data to create one data set whole_data

###Section 2. Extract only the measurements on the mean and standard deviation for each measurement.

> Subset this data to keep only the necessary columns with only mean and std dev measurements, subject_id and activity_id
Using matchcols

### Section 3. Use descriptive activity names to name the activities in the data set

> Setting activity labels , activity_name corresponding to the activity_id using looping ifelse() function 


###Section 4. Appropriately label the data set with descriptive activity names.

> Create a vector with column names 

> Rename the column names with descriptive wordings using gsub() function , ignoring CASE
> Eg. Replace "^(f)" by "freq", "AccMag" by "AccMagnitude", and so on. 

> Put back the defined, descriptive column names back to the dataset
> Re-arranging the column names as the final tidy dataset
> write the final tidy dataset into txt format tidy_data


### Section 5. Create an independent tidy data set with the average of each variable for each activity and each subject.

> Per the project instructions, we need to produce only a data set with the average of each veriable for each activity and subject
