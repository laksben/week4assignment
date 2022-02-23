file_name <- "week4graded.zip"
file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(file_name))
  download.file(file_URL,destfile = file_name,method = "curl")

if(!file.exists("UCI HAR Dataset"))
  unzip(file_name)

# Assigning dataframes

features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$functions)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names = "code")

# Step 1: Merging test and train datasets to one dataset

X <- rbind(x_train, x_test)
Y<- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_df <- cbind(X,Y,subject)

#Step2: Extracting only the measurements on the mean and standard deviation 
# for each measurement.

library(dplyr)
tidydf <- select(merged_df,subject,code,contains("mean"),contains("std"))

# Step 3: Using descriptive activity names to name the activities in the data set
tidydf$code <- activities[tidydf$code,2]

#Step 4: Appropriately labeling the data set with descriptive variable names

names(tidydf)[2] <- "Activity"
names(tidydf)<-gsub("Acc", "Accelerometer ", names(tidydf))
names(tidydf)<-gsub("Gyro", "Gyroscope ", names(tidydf))
names(tidydf)<-gsub("BodyBody", "Body ", names(tidydf))
names(tidydf)<-gsub("Mag", "Magnitude ", names(tidydf))
names(tidydf)<-gsub("^f", "Frequency ", names(tidydf))
names(tidydf)<-gsub("^t", "Time ", names(tidydf))

# Step 5: From the data set in step 4, creating a second, independent 
# tidy data set with the average of each variable for 
# each activity and each subject.

final_data <- group_by(tidydf,subject,Activity)
out_data <- summarise_all(final_data,mean)


write.table(out_data,"OutData.txt",row.names = FALSE)
