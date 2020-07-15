# Getting and Cleaning Data Course Project

Repository for the project of "Getting and Cleaning Data" course from Johns Hopkins University on Coursera.

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. For that, this project collect a data from the accelerometer and gyroscope of the Samsung Galaxy S smartphone, work with and clean it, in order to prepare a tidy data that can be used for later analysis.

A full description of the data is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Repository contents

This repository contains the following files:

- **run_analysis.R** - the R script used to create the tidy data.
- **tidy_data.txt** - tidy data obtained after clean and worth with the original data set. Created by running the run_analysis.R script using R version 4.0.0 on Windows 10 64-bit edition.
- **CodeBook.md** - Code book that describes the contents of the data set.

## The R Script


The R script `run_analysis.R`was used to create the data set. It retrieves the source data set, merges together training and test to create one data set, then the measurements on the mean and standard deviation are extract for each measurement (79 variables from the original 561), and then the measurements are average for each subject and activity, resulting in the final tiny data implementing the following steps:

* Download the dataset if it does not already exist in the working directory and then unzip it.
* Read the features info and appropriately it with descriptive variable names.
* Load the activity info and both the training and test data sets.  
* Merge the training and test datas to create one data.
* Extract only the measurements on the mean and standard deviation for each measurement.
* Convert the activity and subject columns into factors.
* Creates a tidy dataset that consists of the average (mean) value of each variable for each activity subject pair.
* Write the data set to the `tidy_data.txt` file.

## Instructions

Get the tiny data performing the following steps:

- Download the `run_analysis.R` script.
- Move the script to the working directory.
- Run the following command: > `source("run_analysis.R")`


