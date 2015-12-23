# Getting_Cleaning_Data_Project1
JHU Coursera Course - Getting and Cleaning Data 
##Class Project 1


This R script reads in accelerometer data from the UCS Handset Dateset
from the current working directory and combines the train and test data 
into a single dataframe.

It then applies labels to the columns, and descriptive names
to the 'Activity' row.

Next all columns that have 'mean' or 'std' in the column name are subsetted.

The 'Activity' column is re-labeled with descriptive names.

Re-order the data by Activity and Subject and outputs to 'g' 
a mean of each measurement column per Subject and Activity.

Outputs the 'g' data set to GCD_Project1.txt in the working directory.