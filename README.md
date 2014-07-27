##README.md

A script that processes the Human Activity Recognition Using Smartphones Dataset Version 1.0 (see CodeBook.md for additional details) to produce a tidy dataset consisting of the mean and standard deviation measures from the data, averaged across subjects and activity types.

#This repo includes the following items:
- This file (README.md)
- A codebook (CodeBook.md) describing the data and the processing script including variables, the data, and any transformations or work performed to clean up the data
- An R script (run_analysis.R) that generates the tidy dataset, using the following steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
 