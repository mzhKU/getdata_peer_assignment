# Description of run_analysis.R

By Martin Hediger

## Overview
This script merges the training and test sets obtained
from a motion sensor in a mobile phone and performs some
data transformations to arrive at a tidy data set.
First, the training and test data is merged to a total data set
(`xytot`). The data obtained from the sensors corresponding 
to mean and standard deviations are extracted from merged data
set (`means_stds`).
A tidy data set is prepared by first melting the data by
individuals and activity and then calculating the mean of
each feature per individual and activity.

The tidy data set is of the following shape:

```
Measurement   Subject ID       Activity Label   Feature 1   Feature 2   [...] 
          1           1            "WALKING"     <VALUE>     <VALUE>
          2           1   "WALKING UPSTAIRS"     <VALUE>     <VALUE>
      [...]
          7           2            "WALKING"     <VALUE>     <VALUE>
      [...]
        180          30             "LAYING"     <VALUE>     <VALUE>
```

where the Features are those which report a mean or SD measurement.
The tidy data set is uploaded as 'means_stds_cast.txt'.


## How to execute the script
The script is called by executing
$ ./run_analysis.R
on the command line.


## Requirements
In the directory of the script, a directory
called 'UCI HAR Dataset' needs to be present and
containing the data from the assignment in its
original form (i.e. the 'test' and 'train' directories
need to be present with their content from the original
zip file. The original data is found under
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
