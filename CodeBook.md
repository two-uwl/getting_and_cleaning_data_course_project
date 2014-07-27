##CodeBook.md

run_analysis.R : An R script to generate a tidy dataset based on the Human Activity Recognition Using Smartphones Dataset Version 1.0. Original dataset by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto, Smartlab - Non Linear Complex Systems Laboratory, DITEN - Universit‡ degli Studi di Genova, Genoa, Italy.

Reference:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


Description of the experiment, from the documentation included with the original dataset: 

“The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data… 
For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.”

The R script prepares a tidy dataset that includes the values of the 79 mean and standard deviation measures from the original 561-feature dataset, averaged for each subject and activity. 
#The steps included in the script for data processing include:
- Merging test and training datasets, using rbind().
- Adding columns to designate the activity type (both numeric format and text descriptors) and subject number, using cbind().
- Extracting the 79 variables that represent mean and standard deviation measures, using subsetting operators.
- Making the data frame more readable by adding descriptive column headers
- Preparing a narrow-format tidy dataset that includes the average values for each subject-activity combination for each of the 79 mean and standard deviation measure variables, using reshape2::melt and plyr::cast functions.
- Throughout the script, dimensions of data frames are checked to make sure that all operations (merges and transformations) worked properly.

A description of the features generated from the dataset is as follows, from the documentation included with the original data:
“The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.”

From the information above, Reyes-Ortiz et al. named the variables as follows:
- tBodyAcc-XYZ  (separated into X, Y, and Z components)
- tGravityAcc-XYZ (separated into X, Y, and Z components)
- tBodyAccJerk-XYZ (separated into X, Y, and Z components)
- tBodyGyro-XYZ (separated into X, Y, and Z components)
- tBodyGyroJerk-XYZ (separated into X, Y, and Z components)
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ (separated into X, Y, and Z components)
- fBodyAccJerk-XYZ (separated into X, Y, and Z components)
- fBodyGyro-XYZ (separated into X, Y, and Z components)
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag



A set of variables were estimated from these signals. The measures included in the processed dataset include of mean values, designated as mean(), and standard deviation values, designated as std(). Variables included in the dataset include:
[1] "1 tBodyAcc-mean()-X"                 "2 tBodyAcc-mean()-Y"                 "3 tBodyAcc-mean()-Z"                
 [4] "41 tGravityAcc-mean()-X"             "42 tGravityAcc-mean()-Y"             "43 tGravityAcc-mean()-Z"            
 [7] "81 tBodyAccJerk-mean()-X"            "82 tBodyAccJerk-mean()-Y"            "83 tBodyAccJerk-mean()-Z"           
[10] "121 tBodyGyro-mean()-X"              "122 tBodyGyro-mean()-Y"              "123 tBodyGyro-mean()-Z"             
[13] "161 tBodyGyroJerk-mean()-X"          "162 tBodyGyroJerk-mean()-Y"          "163 tBodyGyroJerk-mean()-Z"         
[16] "201 tBodyAccMag-mean()"              "214 tGravityAccMag-mean()"           "227 tBodyAccJerkMag-mean()"         
[19] "240 tBodyGyroMag-mean()"             "253 tBodyGyroJerkMag-mean()"         "266 fBodyAcc-mean()-X"              
[22] "267 fBodyAcc-mean()-Y"               "268 fBodyAcc-mean()-Z"               "294 fBodyAcc-meanFreq()-X"          
[25] "295 fBodyAcc-meanFreq()-Y"           "296 fBodyAcc-meanFreq()-Z"           "345 fBodyAccJerk-mean()-X"          
[28] "346 fBodyAccJerk-mean()-Y"           "347 fBodyAccJerk-mean()-Z"           "373 fBodyAccJerk-meanFreq()-X"      
[31] "374 fBodyAccJerk-meanFreq()-Y"       "375 fBodyAccJerk-meanFreq()-Z"       "424 fBodyGyro-mean()-X"             
[34] "425 fBodyGyro-mean()-Y"              "426 fBodyGyro-mean()-Z"              "452 fBodyGyro-meanFreq()-X"         
[37] "453 fBodyGyro-meanFreq()-Y"          "454 fBodyGyro-meanFreq()-Z"          "503 fBodyAccMag-mean()"             
[40] "513 fBodyAccMag-meanFreq()"          "516 fBodyBodyAccJerkMag-mean()"      "526 fBodyBodyAccJerkMag-meanFreq()" 
[43] "529 fBodyBodyGyroMag-mean()"         "539 fBodyBodyGyroMag-meanFreq()"     "542 fBodyBodyGyroJerkMag-mean()"    
[46] "552 fBodyBodyGyroJerkMag-meanFreq()" "4 tBodyAcc-std()-X"                  "5 tBodyAcc-std()-Y"                 
[49] "6 tBodyAcc-std()-Z"                  "44 tGravityAcc-std()-X"              "45 tGravityAcc-std()-Y"             
[52] "46 tGravityAcc-std()-Z"              "84 tBodyAccJerk-std()-X"             "85 tBodyAccJerk-std()-Y"            
[55] "86 tBodyAccJerk-std()-Z"             "124 tBodyGyro-std()-X"               "125 tBodyGyro-std()-Y"              
[58] "126 tBodyGyro-std()-Z"               "164 tBodyGyroJerk-std()-X"           "165 tBodyGyroJerk-std()-Y"          
[61] "166 tBodyGyroJerk-std()-Z"           "202 tBodyAccMag-std()"               "215 tGravityAccMag-std()"           
[64] "228 tBodyAccJerkMag-std()"           "241 tBodyGyroMag-std()"              "254 tBodyGyroJerkMag-std()"         
[67] "269 fBodyAcc-std()-X"                "270 fBodyAcc-std()-Y"                "271 fBodyAcc-std()-Z"               
[70] "348 fBodyAccJerk-std()-X"            "349 fBodyAccJerk-std()-Y"            "350 fBodyAccJerk-std()-Z"           
[73] "427 fBodyGyro-std()-X"               "428 fBodyGyro-std()-Y"               "429 fBodyGyro-std()-Z"              
[76] "504 fBodyAccMag-std()"               "517 fBodyBodyAccJerkMag-std()"       "530 fBodyBodyGyroMag-std()"         
[79] "543 fBodyBodyGyroJerkMag-std()"      "ActLab"                              "Subject"                            
[82] "ActLabels" 

Variables 1-79 are described above. Variable 80 (“ActLab”) and 82 (“ActLabels”) describe the activity type in numeric and text format, respectively, as follows:
- 1 WALKING
- 2 WALKING_UPSTAIRS
- 3 WALKING_DOWNSTAIRS
- 4 SITTING
- 5 STANDING
- 6 LAYING

Variable 81 (“Subject”) denotes the number of the research subject measured.

#The tidy dataset consists of 4 columns: 
- “Subject"  : Subject identifier
— “Activity" : The activity label in text format
- “Variable" : Which of the 79 variables was measured
- “Average"  : The mean value of that variable for the subject-activity pair in that record.
