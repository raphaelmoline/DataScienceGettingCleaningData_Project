# DataScienceGettingCleaningData_Project
project to submit for peer review

How is the script working: see comments in the code, at high level:

- prerequisite is to unzip the data set in the directory used
- get the list of data files full names in the test and train sets
- create an equivalent list of data files full names that will be used for the merged data set
- merge the test and train data sets for each of these files
- parse the features to only retain mean() and std() data
- load and subset the X data set for these features
- load and factorized the activities and subject ids
- bind the 3 tables and create relevant data names
- use dply librabry to group by subject and activity and summarize
- output the new reduced data set in a file called tidy.txt


the repository contains:
- a script to execute the above steps called run_analysis.R
- a reduced data set called tidy.txt
