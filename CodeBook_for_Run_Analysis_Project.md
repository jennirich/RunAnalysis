CodeBook for "Human\_Activity\_Smartphone\_Recognition\_Variable\_Means" dataset:

#\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
**Data Source: UCI HAR Dataset**

Data are from the "Human Activity Recognition Using Smartphones Dataset, Version 1.0" by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto (2012). The data were collected in an experiment using smartphones to record six physical activities for a set of 30 human subjects; the data collection used accelerometers and gyroscopes in the phones.

The data was subsequently processed to create a dataset available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

**Data Set:**

"Human\_Activity\_Smartphone\_Recognition\_Variable\_Means"

Created June 15, 2014 by Jennifer Richards using R. 3.10., working with the following files from the UCI HAR Dataset:

activity\_labels.txt

features.txt

features\_info.txt

README.txt

Subject\_text.txt

X\_test.txt

y\_test.txt

Subject\_train.txt

X\_train.txt

y\_train.txt

#\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

\*\*Processing original data\*\*

"Human\\_Activity\\_Smartphone\\_Recognition\\_Variable\\_Means", (hereafter called the "Means dataset") is derived from a subset of the entire smartphone dataset (the UCI HAR Dataset).

A subset of 66 variables in the UCI HAR Dataset was created by selecting only data variables that were means with standard deviations. Initially, a dataset was created by combining the X, Y, and Subject test and training data files from the original dataset. The X files provided data arranged in columns; columns names were derived from the features.txt file. Y files provided the type of physical activities for each dataset record, numbered as 1-6. Subject files provided the human subject on which each record was taken, numbered 1-30.

The features.txt file was examined in Microsoft Excel to determine which of the 563 variables available represented means and standard deviations of the original data, as indicated by occurring in sets of 3 means plus 3 standard deviations (one for each x, y, and z direction) or in mean/standard deviation pairs. Other variables that had "mean" in their labels but did not have a standard deviation associated were not included.

The 66 variables meeting these criteria were selected from the total dataset by using their row number in the features.txt file to select column numbers in the combined test/training dataset. These variables, combined with the subject and activity datasets, make up the subset used to derive the Means dataset. Columns were ordered in the test/training dataset as in the original dataset; the subject and activity columns were placed first, followed by the variables. The name and position of each column, as well as the original variable name from the UCI HAR Dataset are given in Table 1.

The first column in the dataset is the Subject column. This is a number (1-30) that indicates the subject (person) from which the data was derived.

The second column in the dataset is the Type of Activity column. This is the physical activity being recorded by the phone. This was a number (1-6) in the original dataset. These activity numbers in the original dataset were replaced with descriptions of the six physical activities; the association of a number with an activity description was derived from the activity\_labels.txt file.

The next 66 columns in the dataset are the variables for the processed phone data. The variable descriptions in the original dataset, which were given in the features.txt file, were translated into more readily understood descriptions, using information in the features\_info.txt file, as well as the README.txt file in the original dataset. These derived descriptions, which are a description of what the variable is, were made into a txt file, which was read into R and used to re-label the columns using the names function in R. These descriptions, along with the original variable labels, are given in Table 1. 

Data units: The data in these columns were normalized in the original processing of the UCI HAR Dataset and thus are unit-less and vary between -1 and 1.

#\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

\*\*Creating Means dataset from the subsetted data\*\*

The original data had multiple observations (rows) for each subject for each type of activity. Subject and physical activity means for each variable in the subsetted dataset were created by first melting the dataset into four columns, using subject and activity type as id and creating a new column for type of measurement (variable type). Means of measurement types were obtained using the aggregate function in R:

meanSD1 <- aggregate(newDataM[,4], by=c(newDataM[3],newDataM[1],newDataM[2]), mean)

This created a long dataset (11880 rows) that had a mean value for each type of measurement for each subject and activity. These were separated into different variables (types of measurements) using the cast function, to create a wide dataset that had a mean value (the data) for each type of measurement (one variable per column) for each subject for each type of activity (one row per observation of subject/activity combination). The final dataset has 68 columns (2 id, 66 variable) with 180 rows per column.

The Means dataframe was written to a table using the write.table command in R; a version with a descriptive name, as well as one with a shorter name, was saved.

**Table 1.** Column labels derived from the features.txt file and associated interpretable description. OrigRow represents the row from the processed feature.txt file, "feature" is the original label, and InterpretableDescriptors are the more easily understood descriptions of the data. Subject and Type of Activity were columns added to the dataframe that were derived from the subject\_\*\*.txt and activity\_labels files, rather than from the feature.txt file.

| OrigRow | feature | InterpretableDescriptors |
| --- | --- | --- |
|  |  | Subject |
|  |  | Type\_of\_Activity |
| 1 | tBodyAcc-mean()-X | Mean\_Body\_Acceleration\_Time\_in\_X\_direction |
| 2 | tBodyAcc-mean()-Y | Mean\_Body\_Acceleration\_Time\_in\_Y\_direction |
| 3 | tBodyAcc-mean()-Z | Mean\_Body\_Acceleration\_Time\_in\_Z\_direction |
| 4 | tBodyAcc-std()-X | Standard\_Deviation\_of\_Body\_Acceleration\_Time\_in\_X\_direction |
| 5 | tBodyAcc-std()-Y | Standard\_Deviation\_of\_Body\_Acceleration\_Time\_in\_Y\_direction |
| 6 | tBodyAcc-std()-Z | Standard\_Deviation\_of\_Body\_Acceleration\_Time\_in\_Z\_direction |
| 41 | tGravityAcc-mean()-X | Mean\_Gravity\_Acceleration\_Time\_in\_X\_direction |
| 42 | tGravityAcc-mean()-Y | Mean\_Gravity\_Acceleration\_Time\_in\_Y\_direction |
| 43 | tGravityAcc-mean()-Z | Mean\_Gravity\_Acceleration\_Time\_in\_Z\_direction |
| 44 | tGravityAcc-std()-X | Standard\_Deviation\_of\_Gravity\_Acceleration\_Time\_in\_X\_direction |
| 45 | tGravityAcc-std()-Y | Standard\_Deviation\_of\_Gravity\_Acceleration\_Time\_in\_Y\_direction |
| 46 | tGravityAcc-std()-Z | Standard\_Deviation\_of\_Gravity\_Acceleration\_Time\_in\_Z\_direction |
| 81 | tBodyAccJerk-mean()-X | Mean\_Body\_Acceleration\_Jerk\_Time\_in\_X\_direction |
| 82 | tBodyAccJerk-mean()-Y | Mean\_Body\_Acceleration\_Jerk\_Time\_in\_Y\_direction |
| 83 | tBodyAccJerk-mean()-Z | Mean\_Body\_Acceleration\_Jerk\_Time\_in\_Z\_direction |
| 84 | tBodyAccJerk-std()-X | Standard\_Deviation\_of\_Body\_Acceleration\_Jerk\_Time\_in\_X\_direction |
| 85 | tBodyAccJerk-std()-Y | Standard\_Deviation\_of\_Body\_Acceleration\_Jerk\_Time\_in\_Y\_direction |
| 86 | tBodyAccJerk-std()-Z | Standard\_Deviation\_of\_Body\_Acceleration\_Jerk\_Time\_in\_Z\_direction |
| 121 | tBodyGyro-mean()-X | Mean\_Body\_Angular\_Velocity\_Time\_in\_X\_direction |
| 122 | tBodyGyro-mean()-Y | Mean\_Body\_Angular\_Velocity\_Time\_in\_Y\_direction |
| 123 | tBodyGyro-mean()-Z | Mean\_Body\_Angular\_Velocity\_Time\_in\_Z\_direction |
| 124 | tBodyGyro-std()-X | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Time\_in\_X\_direction |
| 125 | tBodyGyro-std()-Y | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Time\_in\_Y\_direction |
| 126 | tBodyGyro-std()-Z | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Time\_in\_Z\_direction |
| 161 | tBodyGyroJerk-mean()-X | Mean\_Body\_Angular\_Velocity\_Jerk\_Time\_in\_X\_direction |
| 162 | tBodyGyroJerk-mean()-Y | Mean\_Body\_Angular\_Velocity\_Jerk\_Time\_in\_Y\_direction |
| 163 | tBodyGyroJerk-mean()-Z | Mean\_Body\_Angular\_Velocity\_Jerk\_Time\_in\_Z\_direction |
| 164 | tBodyGyroJerk-std()-X | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Jerk\_Time\_in\_X\_direction |
| 165 | tBodyGyroJerk-std()-Y | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Jerk\_Time\_in\_Y\_direction |
| 166 | tBodyGyroJerk-std()-Z | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Jerk\_Time\_in\_Z\_direction |
| 201 | tBodyAccMag-mean() | Mean\_Body\_Acceleration\_Time |
| 202 | tBodyAccMag-std() | Magnitude\_of\_Standard\_Deviation\_of\_Body\_Acceleration\_Time |
| 214 | tGravityAccMag-mean() | Magnitude\_of\_Mean\_Gravity\_Acceleration\_Time |
| 215 | tGravityAccMag-std() | Magnitude\_of\_Standard\_Deviation\_of\_Gravity\_Acceleration\_Time |
| 227 | tBodyAccJerkMag-mean() | Magnitude\_of\_Mean\_Body\_Acceleration\_Jerk\_Time |
| 228 | tBodyAccJerkMag-std() | Magnitude\_of\_Standard\_Deviation\_of\_Body\_Acceleration\_Jerk\_Time |
| 240 | tBodyGyroMag-mean() | Magnitude\_of\_Mean\_Body\_Angular\_Velocity\_Time |
| 241 | tBodyGyroMag-std() | Magnitude\_of\_Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Time |
| 253 | tBodyGyroJerkMag-mean() | Magnitude\_of\_Mean\_Body\_Angular\_Velocity\_Jerk\_Time |
| 254 | tBodyGyroJerkMag-std() | Magnitude\_of\_Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Jerk\_Time |
| 266 | fBodyAcc-mean()-X | Mean\_Body\_Acceleration\_Frequency\_in\_X\_direction |
| 267 | fBodyAcc-mean()-Y | Mean\_Body\_Acceleration\_Frequency\_in\_Y\_direction |
| 268 | fBodyAcc-mean()-Z | Mean\_Body\_Acceleration\_Frequency\_in\_Z\_direction |
| 269 | fBodyAcc-std()-X | Standard\_Deviation\_of\_Body\_Acceleration\_Frequency\_in\_X\_direction |
| 270 | fBodyAcc-std()-Y | Standard\_Deviation\_of\_Body\_Acceleration\_Frequency\_in\_Y\_direction |
| 271 | fBodyAcc-std()-Z | Standard\_Deviation\_of\_Body\_Acceleration\_Frequency\_in\_Z\_direction |
| 345 | fBodyAccJerk-mean()-X | Mean\_Body\_Acceleration\_Jerk\_Frequency\_in\_X\_direction |
| 346 | fBodyAccJerk-mean()-Y | Mean\_Body\_Acceleration\_Jerk\_Frequency\_in\_Y\_direction |
| 347 | fBodyAccJerk-mean()-Z | Mean\_Body\_Acceleration\_Jerk\_Frequency\_in\_Z\_direction |
| 348 | fBodyAccJerk-std()-X | Standard\_Deviation\_of\_Body\_Acceleration\_Jerk\_Frequency\_in\_X\_direction |
| 349 | fBodyAccJerk-std()-Y | Standard\_Deviation\_of\_Body\_Acceleration\_Jerk\_Frequency\_in\_Y\_direction |
| 350 | fBodyAccJerk-std()-Z | Standard\_Deviation\_of\_Body\_Acceleration\_Jerk\_Frequency\_in\_Z\_direction |
| 424 | fBodyGyro-mean()-X | Mean\_Body\_Angular\_Velocity\_Jerk\_Frequency\_in\_X\_direction |
| 425 | fBodyGyro-mean()-Y | Mean\_Body\_Angular\_Velocity\_Jerk\_Frequency\_in\_Y\_direction |
| 426 | fBodyGyro-mean()-Z | Mean\_Body\_Angular\_Velocity\_Jerk\_Frequency\_in\_Z\_direction |
| 427 | fBodyGyro-std()-X | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Jerk\_Frequency\_in\_X\_direction |
| 428 | fBodyGyro-std()-Y | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Jerk\_Frequency\_in\_Y\_direction |
| 429 | fBodyGyro-std()-Z | Standard\_Deviation\_of\_Body\_Angular\_Velocity\_Jerk\_Frequency\_in\_Z\_direction |
| 503 | fBodyAccMag-mean() | Magnitude\_of\_Mean\_Body\_Acceleration\_Frequency |
| 504 | fBodyAccMag-std() | Magnitude\_of\_Standard\_Deviation\_of\_Body\_Acceleration\_Frequency |
