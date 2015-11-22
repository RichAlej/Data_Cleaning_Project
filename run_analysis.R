
#this script mergest test and train data sets in the UCI HAR Dataset
#It extracts only the mean and standard-deviation measurement variables 
#of the different tests for each subject.
#The final product summarizes the average of those measurements over each of the different tests.


library(plyr) #plyr and dplyr will need to be installed in your machine for R first
library(dplyr)

setwd("~/Data Science Specialization/data/UCI HAR Dataset") #this working directory contains all data
                                                            #including "test" and "train" dataset subdirectories

Xtest_table <- read.table("test/x_test.txt")      #mean and other measues of original variables
Xtrain_table <- read.table("train/x_train.txt")

Ytest <- readLines("test/Y_test.txt")  #indicates the activity observed for each row
Ytrain <- readLines("train/Y_train.txt")

subject_test <- readLines("test/subject_test.txt")  #indicates the subject obserbed for each row
SUBtest <- as.integer(subject_test)                #as integer helps functions to order automatically
subject_train <- readLines("train/subject_train.txt")
SUBtrain <- as.integer(subject_train)

TestTable <- mutate(Xtest_table, activities=Ytest, subjects=SUBtest)  #brings activity and subject info with test table 
TrainTable <- mutate(Xtrain_table, activities=Ytrain, subjects=SUBtrain)

Test_Table <- TestTable[,c(563, 562, 1:561)]  #puts subjects and activities on left
Train_Table <- TrainTable[,c(563, 562, 1:561)] 

Complete_Table <- merge(Test_Table, Train_Table, all=TRUE) #merges the two tables

features <- readLines("features.txt")  #features are column names for measure variables
names(Complete_Table)[3:563] <- features 

meanNstd <- select(Complete_Table, contains("subjects"), contains("activities"), contains("mean()"), contains("std()"))
                                #meanNstd is the extraction of only mean and standard deviation measures

activity_labels <- readLines("activity_labels.txt")  #list of names for activities
                                                      #loop adds those names
for(i in seq_along(meanNstd[,2])) {
        meanNstd[i,2] <- activity_labels[as.integer(meanNstd[i,2])] #activity vector index = activity name index
}
     

AvgMnS <- aggregate(meanNstd[ ,3:68], list(subjects = meanNstd$subjects, activities = meanNstd$activities), mean)
                        #calculate average of each measure variable









