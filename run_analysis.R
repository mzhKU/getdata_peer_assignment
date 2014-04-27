#!/usr/bin/env Rscript

# **************************************
# Martin Hediger
# 
# Getting and Cleaining Data - Signature Track
# **************************************


# **************************************
# Preparation
# -----------
# Load data sets:
# The script requires the directory structures
# './uci/test' and './uci/train' to be in the same
# directory as this script.
# X_test: 2974 rows by 561 columns, each row identifies
#         the subject who performed the activity (i.e. a
#         feature vector).
# y_test: 2974 rows by 1 column, each value represents
#         the value obtained by the mapping of f(X) -> y.
# The training sets are analoguous.
#
# Loading test and training data sets. Data are in 'UCI HAR Dataset/test'
# and 'uci/training' directories.
stest  <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
strain <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
xtest  <- read.table("UCI\ HAR\ Dataset/test/X_test.txt",   header=F)
ytest  <- read.table("UCI\ HAR\ Dataset/test/y_test.txt",   header=F)
xtrain <- read.table("UCI\ HAR\ Dataset/train/X_train.txt", header=F)
ytrain <- read.table("UCI\ HAR\ Dataset/train/y_train.txt", header=F)
# **************************************


# **************************************
# Task 1)
# Merge training and test sets to create one data set
# Schematic representation of data merging steps.
#   
#    1              561              1           563
#   ---          ----------         ---      -------------
#   | |          |        |         | |      ||         || 
#   | |         2|        |         | |      ||         || 
#   |id  cbind  9| X_test |  cbind  |Y|  ->  || XY_test ||
#   | |         4|        |         | |      ||         ||
#   | |         7|        |         | |      ||         ||
#   | |          |        |         | |      ||         ||
#   ---          ----------         ---      -------------
#               
#    1              561              1           563
#   ---          ----------         ---      -------------
#   | |          |        |         | |      ||         || 
#   | |         7|        |         | |      ||         || 
#   |id  cbind  3|X_train |  cbind  |Y|  ->  ||XY_train ||
#   | |         5|        |         | |      ||         ||
#   | |         2|        |         | |      ||         ||
#   | |          |        |         | |      ||         ||
#   ---          ----------         ---      -------------

# Prepend the subject id by column.
xtesttmp  <- cbind(stest, xtest)
xtraintmp <- cbind(strain, xtrain)
xytest  <- cbind(xtesttmp, ytest)
xytrain <- cbind(xtraintmp, ytrain)

# Append the xy-training blocks to the xy-test blocks
# consisting of 10299=2947+7352 rows and 563 columns.
xytot <- rbind(xytest, xytrain)
# **************************************


# **************************************
# Task 2)
# Extracting mean and SD data.
# In order to extract the 'mean' and 'std' measurements,
# first the features are labeled using the 'features.txt'
# file- this is done such that 'grep' can be used.
# The last column (the 'y' values) is named manually.
# (Note: the first column of 'features.txt' is just an
#        index 1, 2, ..., therefore 'features[, 2]'
#        is used.)
features <- read.table("./UCI\ HAR\ Dataset/features.txt", header=F)
colnames(xytot) <- c("id", as.character(features[, 2]), "act.code")

# The features are identified using 'grep'. For the purpose of this
# analysis, 'mean' and 'standard deviation' features were construed
# as those features where the 'mean' or 'std' expression is
# identified in the feature label.
features_means <- grep("-mean()", names(xytot), fixed=T)
features_stds  <- grep("-std()", names(xytot), fixed=T)

# Extracting subject id (1), means and SD features and also 'Activity'
# column 563.
means_stds <- data.frame(xytot[, c(1, features_means, features_stds, 563) ])
# **************************************


# **************************************
# Task 3) 
# Loading activity labels.
act <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt")
# **************************************


# **************************************
# Task 4)
# Labeling the activities in the 'means_stds' data frame.
means_stds$act.label <- factor(means_stds[, "act.code"],
                               levels=c(1:6),
                               labels=act[, 2]
                              )
# **************************************


# **************************************
# Task 5)
# Melting the data set.
library(reshape2)
means_stds_melt <- melt(means_stds, id=c("id", "act.label"),
                                    measure.vars=colnames(means_stds[, 2:67])
                       )
# This melted data frame is now cast such that for each id and activity the mean
# for every mean-/SD feature characteristics is calculated.
means_stds_cast2 <- dcast(means_stds_melt, id + act.label ~ variable, mean)
write.table(means_stds_cast, file="means_stds_cast.txt")
# **************************************
