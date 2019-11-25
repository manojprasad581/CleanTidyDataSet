# run_analysis.R
 - The intent if this single script is to create two datasets. DataSet1 and DataSet2
 - createDataSets() is the main driver method to be invoked first
 - read_train_files() reads and creates a DataSet from the training data
    - The variable names created by this dataset would match features from "features.txt"
    - The dataset then is filtered to only those capturing mean and standard deviation measurements
    - New variables to the datset are added via records from "y_train.txt" and "subject_train.txt"
    - The datset then is cross referenced to activies listed under "activity_labels.txt" to provide descriptive activity information instead of an integer label
 - read_test_files() reads and creates a DataSet from the test data
    - The variable names created by this dataset would match features from "features.txt"
    - The dataset then is filtered to only those capturing mean and standard deviation measurements
    - New variables to the datset are added via records from "y_test.txt" and "subject_test.txt"
    - The datset then is cross referenced to activies listed under "activity_labels.txt" to provide descriptive activity information instead of an integer label
 - DataSet1 is created by merging datasets from Train and Test datasets returned by read_train_files() and read_test_files()
 - DataSet2 is created by the function averageActivitySubject() taking DataSet1 as an input
    - Activity and Subject variables are first grouped using group_by()
    - Then using summarise_all(), mean is applied to all other columns
    - Please refer to the CodeBook.md for more details
    
# Result_Data_Sets
 - Directory storing the results (DataSet1, DataSet2) DataSet1.csv, DataSet2.csv, DataSet2.txt
 
# UCI HAR Dataset
 - Directory containing the pre processed raw data
 - All the raw data input to run_analysis.R is from many files stored in this directory
