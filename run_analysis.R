# Peer-graded Assignment: Getting and Cleaning Data Course Project
#
# John Sullivan - 7/8/2017
# Step 0 - My favorite libaries
#


library(dplyr)
library(tidyr)
library(data.table)
library(lubridate)

#
# Step 1 - Get the Data

if (dir.exists("./data")) {cat ("Note: ./data directory present in working directory \n")
} else {dir.create("./data")
        cat("./data directory not present; creating ./data it in working directory \n")}

zip_file_name <- "./data/HAR_Dataset.zip"
if (!file.exists(zip_file_name))  {
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
                  , dest=zip_file_name, mode = "wb") 
        unzip (zipfile=zip_file_name, exdir = "./data")
}

# Step 2 - Read the data tables

# function to read entire directories into data.tables
# Notes: I coded this myself as an exercise without consulting the web.
#
read_whole_dir <- function(data_dir,read_data_files = NULL) {
    cat ("Reading from directory ",data_dir,"\n")
    # Get the files that end in .txt or .csv unless they are already specified
    if (is.null(read_data_files))  {read_data_files <- grep(".txt$|.cvs$",dir(data_dir,include.dirs = FALSE),value=TRUE)}
    # Start the loop to read the files
    for (i in seq_along(read_data_files)) {
        cat(paste(paste0(data_dir,"/",read_data_files[i])," --> ",gsub(".txt","",read_data_files[i])),"\n")
        assign(gsub(".txt","",read_data_files[i]),fread(paste0(data_dir,"/",read_data_files[i]),header=FALSE),envir = .GlobalEnv)
    }
}

read_whole_dir("./data/UCI HAR Dataset/test/Inertial Signals")
read_whole_dir("./data/UCI HAR Dataset/train/Inertial Signals")
read_whole_dir("./data/UCI HAR Dataset/test")
read_whole_dir("./data/UCI HAR Dataset/train")
read_whole_dir("./data/UCI HAR Dataset",c("features.txt","activity_labels.txt"))

# Step 3 - Merge the training and test datasets
cat("Merging data sets. \n")
HAR_datasets <- gsub("_train$","",grep("_train$",ls(),value=TRUE))
for (i in seq_along(HAR_datasets)) {
    cat(paste0("HAR_",HAR_datasets[i]),"<- ",paste0(HAR_datasets[i],"_train")," + ",paste0(HAR_datasets[i],"_test"),"\n")
    assign(paste0("HAR_",HAR_datasets[i]),bind_rows(get(paste0(HAR_datasets[i],"_train")), get(paste0(HAR_datasets[i],"_test"))))
}

# Step 4 - Create Means and Std for granular data sets
cat("\n Creating Means and Std for granular data sets \n")
HAR_granular_ds <- grep("^HAR_body|^HAR_total",ls(),value=TRUE)
HAR_granular_mstd <- data.table("obs_num" = 1:nrow(get(HAR_granular_ds[1])))
for (i in seq_along(HAR_granular_ds)) {
    cat(paste0("Extracting mean() and std() from ",HAR_granular_ds[i]," and adding it to HAR_granular_mstd \n"))
    HAR_granular_mstd <- cbind(HAR_granular_mstd,
        select (
            cbind("obs_num" = 1:nrow(get(HAR_granular_ds[i])), get(HAR_granular_ds[i])) %>%
            gather(datac,result,V1:V128) %>%
            group_by(obs_num) %>%
            summarize(mn=mean(result),std=sd(result)) %>%
            rename_(.dots=setNames(c("mn","std"), c(paste0(HAR_granular_ds[i],"_mean"),paste0(HAR_granular_ds[i],"_std"))))
        ,-obs_num)
    )
}

# Step 5 - Assign missing label names
setnames(HAR_X,names(HAR_X),features$V2)
setnames(HAR_y,"V1","ActivityID")
setnames(HAR_subject,"V1","Test_SubjectID")
setnames(activity_labels,c("V1","V2"),c("ActivityID","ActivityLabel"))

# Step 6 - create the tidy dataset by cbinding the component datasets
HAR_X_keep <- grep("mean\\(\\)|std\\(\\)",names(HAR_X),value=TRUE) #Columns to Keep
HAR_tidy_pre <- cbind(
        HAR_subject,
        left_join(HAR_y, activity_labels, by = "ActivityID"),
        transmute(HAR_granular_mstd, TestTrain = as.factor(ifelse(obs_num <= nrow(subject_train),"Train","Test"))),
        select(HAR_granular_mstd,-obs_num),
        HAR_X[,..HAR_X_keep]
        )

# Take the averages of all the variables
HAR_tidy <- HAR_tidy_pre[ , lapply(.SD, mean), by = .(Test_SubjectID,ActivityID,ActivityLabel,TestTrain)]
HAR_tidy <- arrange(HAR_tidy,Test_SubjectID,ActivityID)

# Step 7 - Write out the tidy dataset
write.table(HAR_tidy,"./data/HAR_tidy.txt",row.name=FALSE)
