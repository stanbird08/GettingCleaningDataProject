# GettingCleaningDataProject
This is for a project of coursera course Getting and Cleaning Data Project
Please see the details of the project at https://class.coursera.org/getdata-012/human_grading

The purpose of this project is to practise the knowledge and skills of getting and cleaning data in R.

You get a data at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, which is raw data captured from Samsung Galaxy S smartphone. You can read more details about the data at the website.

You can download the data at, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The project will follow the following instructions to manuplate the data.

    1. create one R script called run_analysis.R that does the following.
    2. Merges the training and the test sets to create one data set.
    3. Extracts only the measurements on the mean and standard deviation for each measurement. 
    4. Uses descriptive activity names to name the activities in the data set
    5. Appropriately labels the data set with descriptive variable names. 
    6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
This repo includes the following files:

-- README.md, this is the file you are reading.

-- CodeBook.md, a technical description of the data set. It describes how the data are arranged in files, what the various numbers and letters mean.

-- run_analysis.R, a R script to get and clean the data into a tiny clean data set and export it as a txt file, named dataFinal.txt. To use this script, you have to have the raw data in your R working directory and in a folder called UCI HAR Dataset which is unzipped from the zip file downloaded from the project website. Please keep the original folder structure, otherwise the script won't work.

============================================
More details about the script, run_analysis.R

The script does the following steps,

1. read features.txt and activity_labels.txt for preparing the data columns names and activity descriptive names

2. read train data and format the data set with meaningful column names and add two more column with subject and activity information

3. read test data and format the data set with meaningful column names and add two more column with subject and activity information

4. merge above two data sets together

5. extract only the columns of the measurements on the mean and standard deviation for each measurement

6. generate a new data set (tidy data) by aggregate the average of each measurement columns grouped by subject and activity

7. export the tidy data as a txt file
 

Stanley, March, 2015

