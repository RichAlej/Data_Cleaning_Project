
##README 
###Script description for the run_analysis.R of UC HAR Dataset



This script merges test and train data sets in the UCI HAR Dataset. It extracts only the mean and standard-deviation measurement variables for each observation set of each subject. The final product summarizes the average of those measurements over each of the different tests.


1. Install and load the plyr and dplyr packages. 

    > library(plyr) 
    > library(dplyr)

2. Set the working directory to the UCI HAR Dataset

    > setwd("~/Data Science Specialization/data/UCI HAR Dataset") 

3. Create R objects for the calculated measures tables

    > Xtest_table <- read.table("test/x_test.txt")      
    > Xtrain_table <- read.table("train/x_train.txt")


4. Create R objects for the activities list, which coresponds to the activity performed for each row of the calculated measures table

    > Ytest <- readLines("test/Y_test.txt")  
    > Ytrain <- readLines("train/Y_train.txt")

5. Create R objects for the subjects list, which corresponds to the subjects who performed the activities for each row of the calculated measures table. 

    > subject_test <- readLines("test/subject_test.txt")  
    > subject_train <- readLines("train/subject_train.txt")

6. Change the subjects variables from characters to integers so that later functions will automatically order the information numerically.

    > SUBtest <- as.integer(subject_test)    
    > SUBtrain <- as.integer(subject_train)

7. Create tables where the subjects and activities lists are columns with information corresponding to the rows of the calculated measures tables.

    > TestTable <- mutate(Xtest_table, activities=Ytest, subjects=SUBtest)  
    > TrainTable <- mutate(Xtrain_table, activities=Ytrain, subjects=SUBtrain)

8. To ease usability and readability, put the subjects and activities columns as the first and second columns, respectively. 

    > Test_Table <- TestTable[,c(563, 562, 1:561)]  
    > Train_Table <- TrainTable[,c(563, 562, 1:561)] 

9. Merge the test and the training tables. This brings together all the data from all subjects.

    > Complete_Table <- merge(Test_Table, Train_Table, all=TRUE) 

10. Create an R object for the "feature" (column) names.

    > features <- readLines("features.txt")  #features are column names for measure variables

11. Replace the automatically generated column names in the table with the appropriate feature names.

    > names(Complete_Table)[3:563] <- features 

12. Create an R object for a table that contains only the mean and standard deviation measures for each set of observations.

    > meanNstd <- select(Complete_Table, contains("subjects"), contains("activities"), contains("mean()"), contains("std()"))

13. Create an R object for the list of activity names and the coding schema for those names.

    > activity_labels <- readLines("activity_labels.txt") 

14. Replace the code numbers in the activities column with the activity labels. (This loop takes advantage of the fact that activity vector index corresponds to activity vector label.)

    > for(i in seq_along(meanNstd[,2])) {meanNstd[i,2] <- activity_labels[as.integer(meanNstd[i,2])]}

15. Create an R object for the final product data table. This table has the mean and standard deviation measures averaged for each set of measure variables for a given activity that a subject performed. 

    > AvgMnS <- aggregate(meanNstd[ ,3:68], list(subjects = meanNstd$subjects, activities = meanNstd$activities), mean)

16. Write this tidy data table to a file called "Average_mean_and_std.txt"

    > write.table(AvgMnS, file = "Average_mean_and_std.txt", row.name=FALSE)
































