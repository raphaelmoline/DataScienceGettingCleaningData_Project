# the zip file has been downloaded and unzipped into the current project directory
# source data is there: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#list files to merge
testfiles <- list.files("UCI HAR Dataset/test",include.dirs = FALSE, full.names = TRUE, recursive = TRUE)
trainfiles <- list.files("UCI HAR Dataset/train",include.dirs = FALSE, full.names = TRUE, recursive = TRUE)

#create merged files names and directories
mergedfiles <- gsub("UCI HAR Dataset/test","UCI HAR Dataset/merged",testfiles)
mergedfiles <- gsub("test.txt","merged.txt",mergedfiles)
if(!file.exists("UCI HAR Dataset/merged")) {dir.create("UCI HAR Dataset/merged")}
if(!file.exists("UCI HAR Dataset/merged/Inertial Signals")) {dir.create("UCI HAR Dataset/merged/Inertial Signals")}

#create merged files and append them with both test and train data
file.create(mergedfiles)
file.append(mergedfiles,testfiles)
file.append(mergedfiles,trainfiles)

# loading the variables of the data set
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

# extracting mean() - and not meanFreq() or std() columns indices and names
mean_std_cols_ref <- grep("mean\\(|std\\(",features[,2])

mean_std_cols_names <- grep("mean\\(|std\\(",features[,2] , value = TRUE)

# reading and subsetting the merged data set
X_merged <- read.table("UCI HAR Dataset/merged/X_merged.txt")
X_merged <- X_merged[,mean_std_cols_ref]
names(X_merged) <- mean_std_cols_names

# reading the subject ids
subject <- read.table("UCI HAR Dataset/merged/subject_merged.txt")
names(subject) <- c("Subject_id")
subject[,1] <- factor(subject[,1])

# reading the activity
activity <- read.table("UCI HAR Dataset/merged/y_merged.txt")
names(activity) <- c("Activity")
labels_activity <- read.table("UCI HAR Dataset/activity_labels.txt")
labels_activity <- labels_activity[,2]
activity[,1] <- factor(activity[,1], labels = labels_activity)

#merge data, subject id and activity
data <- cbind(subject, activity, X_merged)

# create a second data set with average of variables for individual / activity called summary
require(dplyr)
data2 <- tbl_df(data)
data2 <- group_by(data2, Subject_id, Activity)
summary <- summarise_all(data2, funs(mean))




