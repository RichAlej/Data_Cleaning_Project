
##Code Book
###for run_analysis script of UC HAR Dataset


This document describes the data, the variables, and the work down to clean up the data in the run_analysis.R script. Some of the content of this document has been modified from the full description of the source UC HAR Dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


###Background of the HAR source Dataset

Human Activity Recognition (HAR) database was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. For more about the source data from the UC HAR Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The source data files contain data in a bunch of seperate files pertaining to the measures carried about by the HAR experiment. The data is split into "Test" and "Train" datasets, corresponding to the 30% testing data and the 70% training data required by the design of the experiment. In what follows, my mention of the "test" data files also corresponds to the "train" data files. The 561 features in features.txt are the columns for each row of x_test.txt. The x_test.txt are calculations of the measurments from the "Intitial Signals" observations, and the features describe these calculations. Calculations include standard deviation, mean, and many others. Each element of "inertial signals" data has a 128 samples vector for a given test of a subject and task. The subject corresponding to each vector are coded by subject_test.txt and the activities by y_test.txt. There are a total of 30 subjects and 6 activities. Activities are numbered according to names given by activity_labels.txt.



The following summary is modified from the source HAR 'README.txt'

*'features_info.txt': Shows information about the variables used on the feature vector.

*'features.txt': List of all features.

*'activity_labels.txt': Links the class labels with their activity name.

*'train/X_train.txt': Training set.

*'train/y_train.txt': Training labels.

*'test/X_test.txt': Test set.

*'test/y_test.txt': Test labels.

*'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

*'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

*'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

*'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 



### Overview of the run_analysis.R Script 

The run_analysis.R script merges test and train data sets. It extracts only the mean and standard-deviation measurement variables for each set of observations of a subject and activity pairing. The final product is a data table that summarizes the average of those measurement for each subject and activity pairing. 

The following general steps were taken to clean the source data to get the summary table (For a more thorough list of steps and scripting information, see the README.md):

1. The follwing data was combined to make test and training tables: Calculated measurements for each observation set of measurements for a given subject-activity pairing (e.g. Y_test.txt); Subject indication for each row of calculated measurements (e.g. subject_test.txt); Activity indication for each row of calculated measurements(e.g. test/Y_test.txt)

2. The test and training tables were then combined to make one table. The feature (column)labels from features.txt and the activity (row) labels from activity_labels.txt were applied to this table.

3. Only feature variables corresponding to mean and standard deviation were extracted from the data table, and so the data table was made significantly smaller.

4. Again, the data table was made smaller by summarizing this information. In this summary, each row corresponds to the average for each set of observations of a given subject-activity pairing.

5. The final tidy data table is saved as, "write.table "Average_mean_and_std.txt".



###Variables of the Average_mean_and_std Tidy Data table


Given the features and summarizing tasks, Average_mean_and_std.txt has 68 columns and 180 rows. The 68 columns correspond to the features described below (e.g. "tBodyAcc-mean()-X"). Each column name has the number corresponding to the original HAR dataset. The 180 rows correspond to the subject-activity groupings that are summarized in this data table from the original 10,000+ rows (wherein each row corresponded to calculations on a single set of observations for a given subject and activity trial.)

Much of the following is modified from the "features_info.txt" of the UCI HAR Dataset files. 

The features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals and then averaged over for each set of subject-activity pairings are: 

mean(): Mean value
std(): Standard deviation

The units for the acceleration signals from the smartphone accelerometer axes (i.e. "Acc" measurements")are in standard gravity units 'g'. The units for the angular velocity vector measured by the gyroscope (i.e. "Gyro" measurements) are in radians/second. 

