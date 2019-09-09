This file describes the five main steps executed for transforming from collected data into tidy.

1. *Download the raw data set*
Data set is download from the link provided by the course project

#. *Read all required files*
Filenames are set into variables and then used to read the content of
each file to memory space, considering the low sized. Feature names are
assign from _features.txt_ file into features columns.

#. *Merge test and train*
For each group (features, activity and subject), train and test data set
are merged together.

#. *Select standard deviation and mean columns*
Using features names, only those containing "std" or "mean" in the name
are keept.

#. *Final tidy data set*
Tidy data set are built by joining subject, activity and features data.

#. *Descriptive columns*
Expand on the column names are done by transforming:
  - t -> Time
  - f -> Frequency
  - Acc -> Accelerometer
  - Gyro -> Gyroscope
  - mean -> Mean
  - meanFreq -> Mean
  - std -> STD
  - BodyBody -> Body

