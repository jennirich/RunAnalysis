setwd('C:/Rrepos/Rdata/Tidy')
getwd()

#****************************************************************************************************
#GETTING THE DATA

#download the dataset
urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlFile, destfile = 'C:/Rrepos/Rdata/Tidy/runAnalysis.zip')

#unzip the dataset
unzip('C:/Rrepos/Rdata/Tidy/runAnalysis.zip', unzip = "internal")

#****************************************************************************************************
#GETTING THE DATA INTO R AND COMBINING INTO A SINGLE FILE

#read in the features
features <- read.table('C:/Rrepos/Rdata/Tidy/runAnalysis/features.txt')

#make a table of the features to work with in excel for renaming columns
write.table(features, file = 'C:/Rrepos/Rdata/Tidy/runAnalysis/features.csv')

#read in X test file, y test and subject test files
Xtest <- read.table ('C:/Rrepos/Rdata/Tidy/runAnalysis/X_test.txt')

Ytest <- read.table ('C:/Rrepos/Rdata/Tidy/runAnalysis/Y_test.txt')

subTest <- read.table ('C:/Rrepos/Rdata/Tidy/runAnalysis/subject_test.txt')

#add Y and subjects to X test
Xtest[c(562:563)] <- c(Ytest, subTest)

#read in X train, Y train and Y subject train files
Xtrain <- read.table ('C:/Rrepos/Rdata/Tidy/runAnalysis/X_train.txt')

Ytrain <- read.table ('C:/Rrepos/Rdata/Tidy/runAnalysis/Y_train.txt')

subTrain <- read.table ('C:/Rrepos/Rdata/Tidy/runAnalysis/subject_train.txt')

#add Y to X train
Xtrain[c(562:563)] <- c(Ytrain, subTrain)

#add test data to training data
data <- rbind(Xtest, Xtrain)

#****************************************************************************************************
#MAKE A SUBSET OF THE OVERALL DATA THAT HAS THE COLUMNS OF INTEREST

#create vector of columns that I want to subset; I am using only columns that have mean and
#standard deviation for same feature (=variable); the subject and activity columns are put first
meanSD <- data.frame(c(data[,c(563,562,1:6,41:46,81:86,121:126,161:166,201:202,214:215,
          227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)]))

#****************************************************************************************************
#REPLACE ACTIVITY NUMBERS WITH ACTIVITY DESCRIPTIONS IN DATAFRAME

#Read in activity labels with their associated numbers
activity <- read.table('C:/Rrepos/Rdata/Tidy/runAnalysis/activity_labels.txt', as.is=T)
 
#make a single dataframe of the activity numbers
index <- data.frame(meanSD[,2])
indexfin <- index   
     for (i in 1:6){
          index[i] <- replace(indexfin, indexfin[1]==i, activity[i,2])
          indexfin <- index[i]
     }

#replace the activity numbers in the dataframe with the activity descriptions
meanSD[2] <- indexfin

#make subjects and activities into factors
meanSD[2]<- as.factor(meanSD$V1.1)
meanSD[1]<- as.factor(meanSD$V1.2)

#****************************************************************************************************
#GIVE DESCRIPTIVE NAMES TO COLUMNS IN DATASET

#Read the column labels into R environment; labels were re-worded in excel and saved as a text file 
colLabels <- read.table('C:/Rrepos/Rdata/Tidy/runAnalysis/col_labels.txt', as.is=T)

#give the new column names to the columns
names(meanSD) <- colLabels

#check to see if column labels are the descriptors
head(meanSD,2)
str(meanSD)
#****************************************************************************************************
#CREATE SECOND DATA SET WITH AVERAGE OF EACH VARIABLE BY ACTIVITY AND SUBJECT
#Melt means prior to aggregating, then cast to get final tidy dataset

#get reshape2 library
library(reshape2)

#melt the data.frame
newDataM <- melt(meanSD, id=1:2)

#get means for all of the variables by subject and activity types
meanSD1 <- aggregate(newDataM[,4], by=c(newDataM[3],newDataM[1],newDataM[2]), mean)
head(meanSD1,100)
names(meanSD1)

#separate long format into one with separate variables by casting
meanSD2 <- dcast(meanSD1, Subject+Type_of_Activity ~ variable)
head(meanSD2,10)
names(meanSD2)

#****************************************************************************************************

#rename dataset to a more meaninful name
Human_Activity_Smartphone_Recognition_Variable_Means <- meanSD2

#save a txt file for uploading
write.table(meanSD2, file = "C:/Rrepos/Rdata/Tidy/newHuman_Activity_Smartphone_Recognition_Variable_Means", col.names = T, sep = ",", quote = F, row.names = F)

#also save a txt file with the shorter name
write.table(meanSD2, file = "C:/Rrepos/Rdata/Tidy/meanSD2", col.names = T, sep = ",", quote = F, row.names = F)



