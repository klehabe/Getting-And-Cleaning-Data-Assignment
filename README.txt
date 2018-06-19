==================================================================
Getting and Cleaning data Assignment
Version 1.0
==================================================================
Compiled by : Kgomotso Lehabe
==================================================================

This file describes the work done in the creic run_Analysis.R to prepare this file for analysis. This is the data that was collected for an experiment to monitor indivuduals performing different activities while wearing a smartphone on the waist. 

The step performed:
======================================

- Download Files from the website.
- Unzip the file.
- Read in 3 training/testing files and merge them to create one file.
- Read in the features file which maps to each measure, which then gets used to label the columns in x_train/x_test files.
- Read in the activity look up table.
- Read in the subjects file for both training and testing experiments.
- Only extract measures on standard deviation and mean for each subject & activity.
- Summarise this by getting the mean
- Tidy up the data by using desciptive column names.

