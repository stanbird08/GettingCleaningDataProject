### task 1, merges the training and the test sets to create one data set
## read descriptive data which suit for Train and Test data
# inital data file pathes
features.txt <- "UCI HAR Dataset/features.txt"
activity_labels.txt <- "UCI HAR Dataset/activity_labels.txt"

# read features.txt and create data column names 
if(!file.exists(features.txt)){
  stop("The features.txt file do not exist, please download the data.")
}
features_df <- read.table(features.txt, colClasses=c("numeric", "character")
                          , col.names = c("feature_num", "feature_name"))
columnNames_vec <- features_df$feature_name

# read activity_labels.txt
if(!file.exists(activity_labels.txt)){
  stop("The activity_labels.txt file do not exist, please download the data.")
}
activity_labels_df <- read.table(activity_labels.txt, colClasses=c("numeric", "character"))


### read train data and make them clean
# inital data file pathes
subject_train.txt <- "UCI HAR Dataset/train/subject_train.txt"
x_train.txt <- "UCI HAR Dataset/train/X_train.txt"
y_train.txt <- "UCI HAR Dataset/train/y_train.txt"

# read x_train.txt
if(!file.exists(x_train.txt)){
  stop("The X_train.txt file do not exist, please download the data.")
}
x_train_set_df <- read.table(x_train.txt, col.names = columnNames_vec)

# read subject_train.txt
if(!file.exists(subject_train.txt)){
  stop("The subject_train.txt file do not exist, please download the data.")
}
subject_train_df <- read.table(subject_train.txt, col.names=c("subject"))


# read y_train.txt
if(!file.exists(y_train.txt)){
  stop("The y_train.txt file do not exist, please download the data.")
}
y_train_label_df <- read.table(y_train.txt, col.names=c("activity")
                         , colClasses=c("factor"))

# rename the lable number to actual activity name
levels(y_train_label_df$activity) <- activity_labels_df$V2

# glue all data together as one Train data frame
train_df = cbind(subject_train_df, y_train_label_df, x_train_set_df)

### read test data and make them clean
# inital data file pathes
subject_test.txt <- "UCI HAR Dataset/test/subject_test.txt"
x_test.txt <- "UCI HAR Dataset/test/X_test.txt"
y_test.txt <- "UCI HAR Dataset/test/y_test.txt"

# read x_test.txt
if(!file.exists(x_test.txt)){
  stop("The x_test.txt file do not exist, please download the data.")
}
x_test_set_df <- read.table(x_test.txt, col.names = columnNames_vec)

# read subject_test.txt
if(!file.exists(subject_test.txt)){
  stop("The subject_test.txt file do not exist, please download the data.")
}
subject_test_df <- read.table(subject_test.txt, col.names=c("subject"))
                              

# read y_test.txt
if(!file.exists(y_test.txt)){
  stop("The y_test.txt file do not exist, please download the data.")
}
y_test_label_df <- read.table(y_test.txt, col.names=c("activity")
                               ,colClasses=c("factor"))

# rename the lable number to actual activity name
levels(y_test_label_df$activity) <- activity_labels_df$V2

# glue all data together as one Test data frame
test_df = cbind(subject_test_df, y_test_label_df, x_test_set_df)

### combine train and test together
dataAll_df = rbind(train_df, test_df)

### task 2, Extracts only the measurements on the mean and standard deviation for each measurement

# generate a vector contains only column names with mean.. and std.
# because when the mean() became a column name, it was renamed as mean..
columnNames_MeanStd_vec <- names(allData_df)
columnNames_MeanStd_vec <- columnNames_MeanStd_vec[grepl("mean\\.\\.|std\\.\\.", columnNames_MeanStd_vec)]

# generate a data frame only contains mean and standard deviation measurement
dataMeanStd_df <- dataAll_df[, c("subject", "activity", columnNames_MeanStd_vec)]

### task 3, use descriptive activity names to name the activites in the data set
# this task has been done in task 1

### task 4, appropriately labels the data set with descriptive variable names
# this task has been done in task 1

### task 5, from the data set in step 4, creates a second, independent tidy data set
### with the average of each variable for each activity and each subject

# use aggregate to generate the mean of each measurement grouped by subject and activity
attach(dataMeanStd_df)
dataAverage_df <- aggregate(dataMeanStd_df[,3:68], by=list(subject, activity), FUN=mean)
detach(dataMeanStd_df)

# rename the first two columns' names with descriptive names
colnames(dataAverage_df)[1] = "subject"
colnames(dataAverage_df)[2] = "activity"

dataFinal <- dataAverage_df[with(dataAverage_df, order(subject, activity)),]

# export the tidy clean data set as a txt file
write.table(dataFinal, file="dataFinal.txt", row.name=FALSE)