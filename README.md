# Description of run_analysis.R


## Overview
This script merges the training and test sets obtained
from a motion sensor in a mobile phone (called 'xytot').
Then, the data corresponding to mean and standard
deviations are extracted from that merged data set
('means_stds'). A tidy data set is prepared by first
melting the data by individuals and activity and then
calculating the mean of each feature per individual
and activity. The tidy data set is of the following shape:

Measurement   Subject ID       Activity Label   Feature 1   Feature 2   [...] 
-----------------------------------------------------------------------------
          1           1            "WALKING"     <VALUE>     <VALUE>
          2           1   "WALKING UPSTAIRS"     <VALUE>     <VALUE>
      [...]
          7           2            "WALKING"     <VALUE>     <VALUE>
      [...]
        180          30             "LAYING"     <VALUE>     <VALUE>

where the Features are those which report a mean or SD measurement.


## How to execute the script
The script is called by executing
$ ./run_analysis.R
on the command line.


## Requirements
In the directory of the script, a directory
called 'UCI HAR Dataset' needs to be present and
containing the data from the assignment in its
original form.
