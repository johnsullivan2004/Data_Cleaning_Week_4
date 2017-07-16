# Data Cleaning Assignment for week #4
## By John Sullivan

This is the week #4 Assignment for the Coursera Data Concentration Data Cleaning class.

I've use the Human Activity Recognition data Using Smartphones as described by this website:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The input dataset is found here:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

My script is found in the *run_analysis.R* file in this github section.

The code has appropriate comments to explain it's operation.

The output dataset is included as well - *HAR_tidy.txt*.

##  Codebook for HAR_tidy.txt

Each Row is one observation as per tidy dataset requirements.  Note that all these variables are the averages of all the independent samples - and there were many for each test subject and activity.
* Fields that define the observation:
	+ Test_SubjectID - One of the 30 anonymous subjects
	+ ActivityID - Activity ID
	+ ActivityLabel - Corresponding activity type lable
	+ TestTrain - Either Train or Test - indicates which data set
* Next are the derived mean and standard deviations from the raw data.   These are the mean and standard deviations as derived from the 128 measurements for the x/y/z accelerometer, gyroscope, and total.   The script calculates these from the raw Inertial Signal data files.  There are fields for each measurement type, axis, and mean or standard deviation.
	+ HAR_body_acc_x_mean
	+ HAR_body_acc_x_std
	+ HAR_body_acc_y_mean
	+ HAR_body_acc_y_std
	+ HAR_body_acc_z_mean
	+ HAR_body_acc_z_std
	+ HAR_body_gyro_x_mean
	+ HAR_body_gyro_x_std
	+ HAR_body_gyro_y_mean
	+ HAR_body_gyro_y_std
	+ HAR_body_gyro_z_mean
	+ HAR_body_gyro_z_std
	+ HAR_total_acc_x_mean
	+ HAR_total_acc_x_std
	+ HAR_total_acc_y_mean
	+ HAR_total_acc_y_std
	+ HAR_total_acc_z_mean
	+ HAR_total_acc_z_std
* Then, are these variables.  These come from the HAR_X dataset and were derived from extensive processing by the HAR project team.   These are a subset of the HAR_X data - only the means and standard deviations are retained.  See the HAR features_info.txt file for more information.
	+ tBodyAcc-mean()-X
	+ tBodyAcc-mean()-Y
	+ tBodyAcc-mean()-Z
	+ tBodyAcc-std()-X
	+ tBodyAcc-std()-Y
	+ tBodyAcc-std()-Z
	+ tGravityAcc-mean()-X
	+ tGravityAcc-mean()-Y
	+ tGravityAcc-mean()-Z
	+ tGravityAcc-std()-X
	+ tGravityAcc-std()-Y
	+ tGravityAcc-std()-Z
	+ tBodyAccJerk-mean()-X
	+ tBodyAccJerk-mean()-Y
	+ tBodyAccJerk-mean()-Z
	+ tBodyAccJerk-std()-X
	+ tBodyAccJerk-std()-Y
	+ tBodyAccJerk-std()-Z
	+ tBodyGyro-mean()-X
	+ tBodyGyro-mean()-Y
	+ tBodyGyro-mean()-Z
	+ tBodyGyro-std()-X
	+ tBodyGyro-std()-Y
	+ tBodyGyro-std()-Z
	+ tBodyGyroJerk-mean()-X
	+ tBodyGyroJerk-mean()-Y
	+ tBodyGyroJerk-mean()-Z
	+ tBodyGyroJerk-std()-X
	+ tBodyGyroJerk-std()-Y
	+ tBodyGyroJerk-std()-Z
	+ tBodyAccMag-mean()
	+ tBodyAccMag-std()
	+ tGravityAccMag-mean()
	+ tGravityAccMag-std()
	+ tBodyAccJerkMag-mean()
	+ tBodyAccJerkMag-std()
	+ tBodyGyroMag-mean()
	+ tBodyGyroMag-std()
	+ tBodyGyroJerkMag-mean()
	+ tBodyGyroJerkMag-std()
	+ fBodyAcc-mean()-X
	+ fBodyAcc-mean()-Y
	+ fBodyAcc-mean()-Z
	+ fBodyAcc-std()-X
	+ fBodyAcc-std()-Y
	+ fBodyAcc-std()-Z
	+ fBodyAccJerk-mean()-X
	+ fBodyAccJerk-mean()-Y
	+ fBodyAccJerk-mean()-Z
	+ fBodyAccJerk-std()-X
	+ fBodyAccJerk-std()-Y
	+ fBodyAccJerk-std()-Z
	+ fBodyGyro-mean()-X
	+ fBodyGyro-mean()-Y
	+ fBodyGyro-mean()-Z
	+ fBodyGyro-std()-X
	+ fBodyGyro-std()-Y
	+ fBodyGyro-std()-Z
	+ fBodyAccMag-mean()
	+ fBodyAccMag-std()
	+ fBodyBodyAccJerkMag-mean()
	+ fBodyBodyAccJerkMag-std()
	+ fBodyBodyGyroMag-mean()
	+ fBodyBodyGyroMag-std()
	+ fBodyBodyGyroJerkMag-mean()
	+ fBodyBodyGyroJerkMag-std()





