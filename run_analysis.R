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
     
#Replace the numbers with descriptors; this is ugly but it works; NB: could also use plyr revalue() or mapvalue() functions
index1 <- replace(index, index[1]==1, "WALKING")
index2 <- replace(index1, index1[1]==2, "WALKING_UPSTAIRS")
index3 <- replace(index2, index2[1]==3, "WALKING_DOWNSTAIRS")
index4 <- replace(index3, index3[1]==4, "SITTING")
index5 <- replace(index4, index4[1]==5, "STANDING")
index6 <- replace(index5, index5[1]==6, "LAYING")

#replace the activity numbers in the dataframe with the activity descriptions
meanSD[2] <- index6

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

#select the columns to be averaged
cols <- c(3:68)

#create the average data using the aggregate function
newData <- data.frame()
for (i in cols){
     x <- aggregate(meanSD[,i], by=c(meanSD[1],meanSD[2]), mean)
     newData <- rbind(newData, x)
}

#check the new data
head(newData,300)

#create variable labels for long column of averages
data_labels <- colLabels[3:68]
data_labels_all <- rep(data_labels, each=180)

#checking to make sure that variable names match data
test1 <- tapply(meanSD[,3], c(meanSD[1],meanSD[2]), mean)
test1a <- head(newData,180)
test2 <- tapply(meanSD[,22], c(meanSD[1],meanSD[2]), mean)
test3 <- newData[3421:3600,]

#change data label list into vector and attach to dataframe
as.vector(data_labels_all)
is.vector(data_labels_all)
newData$Variable <- data_labels_all
head(newData)

#tidy up names and order of columns in dataframe
names(newData)[3] <- "Variable_Mean"
newData <- newData[c(4,1,2,3)]
head(newData,10)
str(newData)

#unlist the lists in newData so that the write functions will work
newData1 <- as.data.frame(lapply(newData, unlist))

#rename dataset to a more meaninful name
Human_Activity_Smartphone_Recognition_Variable_Means <- newData1

#save a txt file for uploading
write.table(newData1, file = "C:/Rrepos/Rdata/Tidy/Human_Activity_Smartphone_Recognition_Variable_Means", col.names = T, sep = "\t", quote = F, row.names = F)

#also save a txt file with a shorter name
write.table(newData1, file = "C:/Rrepos/Rdata/Tidy/newData", col.names = T, sep = "\t", quote = F, row.names = F)



