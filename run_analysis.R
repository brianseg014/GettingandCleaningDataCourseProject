library(dplyr)

# Download raw data
filename <- "project.zip"

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", filename)

unzip(filename)

# Assign filenames
features_filename <- "UCI HAR Dataset/features.txt"
activities_filename <- "UCI HAR Dataset/activity_labels.txt"
test_x_filename <- "UCI HAR Dataset/test/X_test.txt"
test_y_filename <- "UCI HAR Dataset/test/y_test.txt"
test_subject_filename <- "UCI HAR Dataset/test/subject_test.txt"
train_x_filename <-  "UCI HAR Dataset/train/X_train.txt"
train_y_filename <-  "UCI HAR Dataset/train/y_train.txt"
train_subject_filename <- "UCI HAR Dataset/train/subject_train.txt"

# Read all files
features <- read.table(features_filename)
activies <- read.table(activities_filename)
test_x <- read.table(test_x_filename)
test_y <- read.table(test_y_filename)
test_subject <- read.table(test_subject_filename)
train_x <- read.table(train_x_filename)
train_y <- read.table(train_y_filename)
train_subject <- read.table(train_subject_filename)

# Assing column names for each data set read
names(features) <- c("feature_number", "feature_name")
names(activies) <- c("activity_code", "activity_name")
names(test_x) <- features$feature_name
names(test_y) <- c("activity")
names(test_subject) <- c("subject")
names(train_x) <- features$feature_name
names(train_y) <- c("activity")
names(train_subject) <- c("subject")

# Merge test and train data
features_merged <- rbind(test_x, train_x)
activies_merged <- rbind(test_y, train_y)
subject_merged <- rbind(test_subject, train_subject)

# Select columns with std and mean from features
features_selected <- features_merged[,c(grep("std", features$feature_name), grep("mean", features$feature_name))]

# Create tidy data from subject, activities and feateures
tidy <- cbind(subject_merged, activies_merged, features_selected)

# Replace activity code with activity name
tidy$activity <- activies[tidy$activity, 2]

# Convert into descriptive names the features of tidy
names(tidy) <- gsub("^t", "Time", names(tidy))
names(tidy) <- gsub("^f", "Frequency", names(tidy))
names(tidy) <- gsub("Acc", "Accelerometer", names(tidy))
names(tidy) <- gsub("Gyro", "Gyroscope", names(tidy))
names(tidy) <- gsub("BodyBody", "Body", names(tidy))
names(tidy) <- gsub("-mean()", "Mean", names(tidy))
names(tidy) <- gsub("-meanFreq()", "Mean", names(tidy))
names(tidy) <- gsub("-std()", "STD", names(tidy))

# Summarize all columns to get mean on each
summ <- tidy %>% group_by(activity, subject) %>% summarise_all(mean)