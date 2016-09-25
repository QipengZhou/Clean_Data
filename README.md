## Description

This repo is a work for "Getting and Cleaning Data Course Project" in Cousera Moocs. 

* run\_analysis.R is the specify R script for the project;
* data.txt is the result file. 
* data.info is the codebook.

Notes
=====

The run\_analysis.R is main use the 'dplyr' package. Firstly, read the data test,train,activity\_labels and features. Secondly, use the function of 'rbind' and 'cbind' to concat corresponding data. And then use 'grep' the choice "mean" and "std" features. And the use the function 'inner\_join' in 'dplyr' to get descriptive activity names. The lastly, use 'group\_by' and 'summarise\_each' functions to get the average of each variable for each activity and each subject.
