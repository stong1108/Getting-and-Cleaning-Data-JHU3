---
title: "Human Activity Recognition (Coursera Project) README"
author: "Stephanie Tong"
date: "May 22, 2015"
output: html_document
---

###**The Data**

The data provided for this project was provided by UC Irvine's Machine Learning Repository (accessed via [web](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).

The *"Human Activity Recognition Using Smartphones Data Set"*  summarizes experiments in which 30 volunteers of ages 19-48 equipped with smartphones performed 6 activities:

+ walking

+ walking upstairs

+ walking downstairs

+ sitting

+ standing

+ laying

Each entry of the datasets contains 561 accelerometer & gyroscope smartphone data corresponding to an activity performed by a subject. Since the data was originally developed for practical machine learning, the data was split into a training dataset and a testing dataset. 

###**The Script**

The script `run_analysis.R` does the following:

1. recombines the training and testing sets to create one data set using `rbind()` and `cbind()`

2. extracts mean and standard deviation measurements determined by passing `"mean()"` and `"std()"` through the `grep()` function

3. uses descriptive activity names to identify the activities in the data set using the `gsub()` function to change the integers corresponding to activities to understandable strings given by the file `"activity_labels.txt"`.

4. labels the data set with descriptive variable names

5. creates a second, independent tidy data set with the average of each variable for each activity and each subject

This script was written under the assumption that it exists in the unzipped directory "*UCI HAR Dataset*" (zip file can be downloaded by clicking [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). For the code to run, the `dplyr` package must be installed (the script attempts to load packages using `require()`)