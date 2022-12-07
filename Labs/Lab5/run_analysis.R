
install.packages("dplyr")

library(dplyr)
#task1

#column name's for tables
data <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/features.txt", colClasses = "character")[,2]

#read train, text and activity_labels

train_x <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/train/X_train.txt", col.names = data, check.names = F)
train_y <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
subject.train <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))

test_x <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/test/X_test.txt", col.names = data, check.names = F)
test_y <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/test/Y_test.txt", col.names = c('activity'))
subject.test <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))

act_labels <- read.table("/Users/daria/Desktop/пари/R/UCI HAR Dataset/activity_labels.txt", col.names = c('n','text'))

#join text and train table

alldata <- cbind(rbind(train_x, test_x),
                 rbind(train_y, test_y), 
                 rbind(subject.train, subject.test))

#Ignore missing/duplicate names
data1 <- alldata[, !duplicated(colnames(alldata))]

#task2
data2 <- select(data1,  matches("mean\\(\\)|std\\(\\)|subject|activity"))

#task3
data3 <- within(data2, activity <- factor(activity, labels = act_labels[,2]))

#task4
data4 <- aggregate(x = data3[, -c(67,68)], 
                   by = list(data3[,'subject'], data3[, 'activity']),
                   FUN = mean)

#task5

write.csv(data4, "tidy_dataset.csv", row.names=F)
setwd("/Users/daria/Desktop")
