#Coursera Getting and Cleaning Data * July, 2014
# Problem set script
#You should create one R script called run_analysis.R that does the following. 
#	1.	Merges the training and the test sets to create one data set.
#	2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
#	3.	Uses descriptive activity names to name the activities in the data set
#	4.	Appropriately labels the data set with descriptive variable names. 
#	5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

setwd("~/Downloads/Coursera_Getting-and-Cleaning-Data_July2014/course_project")

# Read data:
setwd("./UCI HAR Dataset")
trainSet <- read.table("./train/X_train.txt")
testSet <- read.table("./test/X_test.txt")
#check dimensions:
dim(trainSet); dim(testSet)

#	Objective 1.	Merge the training and the test sets to create one data set.
# First, create two additional columns: one containing the activity level codes, another containing the subject identifiers
ActLabTrain <- readLines("./train/y_train.txt") #read the file that contains the activity level codes for the training data set
length(ActLabTrain)  #check length to make sure it has the same number of item as the corresponding data frame has rows
ActLabTest <- readLines("./test/y_test.txt") #read the file that contains the activity level codes for the test data set
length(ActLabTest)  #check length to make sure it has the same number of item as the corresponding data frame has rows
SubjectTrain <- readLines("./train/subject_train.txt") #read the file that contains the activity level codes for the training data set
SubjectTest <- readLines("./test/subject_test.txt") #read the file that contains the activity level codes for the test data set

trainSet <- cbind(trainSet, ActLabTrain, SubjectTrain); names(trainSet)[562] <- "ActLab"; names(trainSet)[563] <- "Subject" #Add columns for the activity level code and subject identifierto the training dataset (right side of data frame)
dim(trainSet) #make sure that extra columns were successfully added

testSet <- cbind(testSet, ActLabTest, SubjectTest); names(testSet)[562] <- "ActLab"; names(testSet)[563] <- "Subject" #Add column for the activity level code to the test dataset (right side of data frame)
dim(testSet) #make sure that extra columns were successfully added



# Now, merge the test and training dataset using rbind(), then check dimensions. 
fullData <- rbind(trainSet, testSet)
dim(fullData)  # check to make sure that rbind worked successfully.

###########################

# Objective 2. Extractsonly the measurements on the mean and standard deviation for each measurement.
     # As shown in the file "features_info.txt", the measurements containing mean and standard deviation are noted as follows:
     	# mean(): Mean value
     	# std(): Standard deviation
     # Therefore, once the measurement names are applied to the appropriate columns, a subset can be made by selecting for column names that include "mean()" or "std()".
  
# Applying the measurement names:
features <- readLines("features.txt")
# Add an entry for the added column for activity label code:
length(features) #check length
features[562] <- "ActLabel"; features[563] <- "Subject" #add to end of vector
tail(features) #check
#Now apply the features as column names for the data frame:
names(fullData) <- features
head(fullData) #check

# Subsetting the data frame:
labels <- c("-mean()", "-std()")
fullData_mean <- fullData[,grep(labels[1], names(fullData))] #subset of variables with mean values
fullData_std <- fullData[,grep(labels[2], names(fullData))]  #subset of variables with standard deviation values
fullData_meanStd <- cbind(fullData_mean, fullData_std, fullData$ActLab, fullData$Subject) #combine the two subsets, as well as the Activity Label and Subject columns
#Rename the activity label column
dim(fullData_meanStd)
names(fullData_meanStd) [80] <- "ActLab"; names(fullData_meanStd) [81] <- "Subject"

###########################
#Objective 3: Use descriptive activity names to name the activities in the data set
  # i.e., replace the numeric labels in the Activity Label ("ActLab") column to correspond to the activity names in the file "activity_labels.txt"
  # I opted to use the mapvalues function in the plyr package for this objective
ActLabels <- plyr::mapvalues(fullData_meanStd$ActLab, c("1", "2", "3", "4", "5", "6"), c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
fullData_meanStd <- cbind(fullData_meanStd, ActLabels)  

###########################
#Objective 4: Appropriately labels the data set with descriptive variable names. 
   # I performed this objective as part of objective #2.  
   
###########################
# Objective 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
# Melt the data frame so that all measured variables occupy a single column
library(reshape2)
fullDataMelt <- melt(fullData_meanStd, id = c("Subject", "ActLabels"), measure.vars = colnames(fullData_meanStd)[1:79])
head(fullDataMelt,600)
dim(fullDataMelt)
# Calculate the averages for each activity/subject combination:
meanData <- dcast(fullDataMelt, Subject + ActLabels ~ variable, mean)
# Put the data back into tidy form, and clean up the column names a little:
tidyData <- melt(meanData, id = c("Subject", "ActLabels"), measure.vars = colnames(meanData)[3:81]); names(tidyData)[2] <- "Activity"; names(tidyData)[3] <- "Variable"; names(tidyData)[4] <- "Average"
# Check the dimensions of tidy data table to make sure that it includes records for averages of 79 mean and standard deviation measures * 30 subjects * 6 activities = 14,220 lines.
dim(tidyData)   # 14,220 lines * 4 columns; success!
write.table(tidyData, file = "tidy_data.txt")