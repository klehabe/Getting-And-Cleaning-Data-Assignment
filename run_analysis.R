##Download Files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="FUCI.zip")
folder <- getwd()
unzip("FUCI.zip", exdir=folder)

#Read in training data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Read in test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Read in features
 features <- read.table("./UCI HAR Dataset/features.txt")

#Read in activity label
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Add columns names to training data
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

#Add column names to test data
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

#Add column names to activity_labels
colnames(activity_labels) <- c("activityId","activity")

# Put Training data together
training_data <- cbind(y_train, subject_train, x_train)

#Put Testing data together
testing_data <- cbind(y_test, subject_test, x_test)

#Merge training and testing data
train_and_test <- rbind(training_data, testing_data)

#Extract only measurements on mean and std deviation 
 #Get the column names from features
 mean_and_std_columns <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
 
 #create a vector of colums names
 subset_columns <- c("activityId", "subjectId", as.character(mean_and_std_columns))

 #Subset the data  
  subset_data<-subset(train_and_test,select=subset_columns)

#Look up activity from the activity_labels data the drop activityID
 subset_data_with_activity <- merge(activity_labels, subset_data, by= "activityId")
  subset_data_with_activity2 <- within(subset_data_with_activity, rm(activityId))

#Make Variable Names Descriptive
#From features Info
  #prefix 't' to denote time
  # Acc is Accelerometer
  # Gyro is Gyroscope
  # Mag is Magnitude
  # f is frequency

colnames(subset_data_with_activity2)<-gsub("^t", "time", colnames(subset_data_with_activity2))
colnames(subset_data_with_activity2)<-gsub("Acc", "Accelerometer", colnames(subset_data_with_activity2))
colnames(subset_data_with_activity2)<-gsub("Gyro", "Gyroscope", colnames(subset_data_with_activity2))
colnames(subset_data_with_activity2)<-gsub("Mag", "Magnitude", colnames(subset_data_with_activity2))
colnames(subset_data_with_activity2)<-gsub("^f", "frequency", colnames(subset_data_with_activity2))

#Get average For each activity by subject
tidy_data_set <- aggregate(. ~activity + subjectId , subset_data_with_activity2, mean)