# Code book

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

## 1. Download the dataset

  Dataset downloaded and extracted under the folder called UCI HAR Dataset
  
  @@ 2. Assign each data to variables
  
  - features <- features.txt
  
    The features selected for this database come from the accelerometer and     gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
    
    - activities <- activity_labels.txt
    
    List of activities performed when the corresponding measurements were taken and its codes (labels)
    
    - subject_test <- test/subject_test.txt
        ontains test data of 9/30 volunteer test subjects being observed
    
    - x_test <- test/X_test.txt 
        contains recorded features test data
    
    - y_test <- test/y_test.txt 
        contains test data of activities’code labels
    
    - subject_train <- test/subject_train.txt
        contains train data of 21/30 volunteer subjects being observed
    
    - x_train <- test/X_train.txt
        contains recorded features train data
    
    - y_train <- test/y_train.txt
        contains train data of activities’code labels
        
        ## 3. Merges the training and the test sets to create one data set
        
        X  is created by merging x_train and x_test using rbind() function
        Y is created by merging y_train and y_test using rbind() function
        Subject  is created by merging subject_train and subject_test using rbind() function
        
        merged_df is created by merging Subject, Y and X using cbind() function
        
        ## 4. Extracts only the measurements on the mean and standard deviation for each measurement
        
        tidy_df  is created by subsetting Merged_df, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement
        
        ## 5. Uses descriptive activity names to name the activities in the data set
        Entire numbers in code column of the tidy_df replaced with corresponding activity taken from second column of the activities variable
        
        ## 6. Appropriately labels the data set with descriptive variable name
        "code" column renamed to " activities"
        short names in column names replaced as below
        "Acc"  with  "Accelerometer"
        "Gyro" with "Gyroscope"
        "BodyBody" with "Body"
        "Mag"  with "Magnitude"
        starting with letter "f" with "frequency"
        starting with letter "t" with "time"
        
        ##7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
        
        out_data (180 rows, 88 columns) is created by sumarizing tidy_df taking the means of each variable for each activity and each subject, after groupped by subject and activity.
        
        Export out_data into OutData.txt file
        
        
        