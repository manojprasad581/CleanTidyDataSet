#Creates DataSet related to Training Data
read_train_files <- function(labels, features) {
    train_Y_set <- read.table("./UCI HAR Dataset/train/y_train.txt")
    names(train_Y_set) <- "Label"
    train_subject_test_set <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    names(train_subject_test_set) <- "Subject"
    train_X_set <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$Feature)
    
    #Retain columns with names matching either std or mean
    train_X_set <- train_X_set[grep("*mean|std*", names(train_X_set))]
    
    #Add a new column to capture descriptive activity information
    train_X_set <- mutate(train_X_set, Label = train_Y_set$Label)
    train_X_set <- merge(train_X_set, labels, by.x = "Label", by.y = "Label")
    train_X_set <- within(train_X_set, rm(Label))
    
    #Add a new column to capture the Subject information
    train_X_set <- mutate(train_X_set, Subject = train_subject_test_set$Subject)
    
    #Return
    train_X_set
}

#Creates DataSet related to Test Data
read_test_files <- function(labels, features) {
    test_Y_set <- read.table("./UCI HAR Dataset/test/y_test.txt")
    names(test_Y_set) <- "Label"
    test_subject_test_set <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    names(test_subject_test_set) <- "Subject"
    test_X_set <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$Feature)
    
    #Retain columns with names matching either std or mean
    test_X_set <- test_X_set[grep("*mean|std*", names(test_X_set))]
    
    #Add a new column to capture descriptive activity information
    test_X_set <- mutate(test_X_set, Label = test_Y_set$Label)
    test_X_set <- merge(test_X_set, labels, by.x = "Label", by.y = "Label")
    test_X_set <- within(test_X_set, rm(Label))
    
    #Add a new column to capture the Subject information
    test_X_set <- mutate(test_X_set, Subject = test_subject_test_set$Subject)
    
    #Return
    test_X_set
}

#Creates DataSet2
averageActivitySubject <- function(dataSet1) {
    #Group By Activity and Subject
    groupByActivitySubject <- group_by(dataSet1, Activity, Subject)
    
    #Compute the mean for all columns
    dataSet2 <- summarise_all(groupByActivitySubject, mean)
    
    #Return
    dataSet2
}

#Main Driver function -> Creates DataSet1 and DataSet2
createDataSets <- function() {
    library(dplyr)
    labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    names(labels) <- c("Label", "Activity")
    features <- read.table("./UCI HAR Dataset/features.txt")
    names(features) <- c("ID", "Feature")
    
    train_data_set <- read_train_files(labels, features)
    View(train_data_set)
    
    test_data_set <- read_test_files(labels, features)
    View(test_data_set)
    
    dataSet1 <- rbind(train_data_set, test_data_set)
    View(dataSet1)
    write.csv(dataSet1, "./DataSet1.csv")
    
    dataSet2 <- averageActivitySubject(dataSet1)
    View(dataSet2)
    write.csv(dataSet2, "./DataSet2.csv")
}