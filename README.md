# CleaningData
Course Project for Getting and Cleaning Data

## Code Description
The following files must be in the same directory as the run_analysis.R file:
1. subject_test.txt
2. X_test.txt
3. y_test.txt
4. subject_train.txt
5. X_train.txt
6. y_train.txt
7. features.txt

## Other important files in order to understand the data are:
1. features_info.txt
2. activity_labels.txt

## Description of the run_analysis.R script:
First, the script pulls in the the 3 test and 3 training files. It combines them and adds several columns to make analysis easier: the test_ds column and the metric column. The script then pulls out only the variables that have to do with a mean or standard deviation. Finally, the script looks at the mean and standard deviation of the variables selected. The final dataset (tidy.txt) is a long version of the mean variables showing the subject, test_ds, metric (i.e. mean), the variable and finally the value.
