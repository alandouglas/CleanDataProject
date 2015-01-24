## Reading in the data from the files.

Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")

SubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
SubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

## We begin construction of our larger data table by binding the subjects together by row.

buildingClean1 <- rbind(Xtest, Xtrain)
extraColumn1 <- rbind(SubjectTest, SubjectTrain)

## Column binding these two togther as appropriate.

buildingClean2 <- cbind(buildingClean1, extraColumn1)

## Here, we are constructing an extra column which will be binded onto the end
## of the data frame. Initially this column is set up as an empty character vector
## of the appropriate length of the data table. The values of this column are then inserted
## induvidually with a while loop; where the values are the string of the activity description
## being measured in that particular observation, where the activity description
## is converted from the activity number as in the activity_labels.txt data provided.

extraColumn2 <- rbind(Ytest,Ytrain)
extraColumn3 <- character(length=nrow(extraColumn2))
counter = 1
while(counter <= length(extraColumn3)){
    extraColumn3[counter]=as.character(activityLabels[extraColumn2[counter, 1], 2])
    counter = counter+1
}

## This column is now binded.

buildingClean3 <- cbind(buildingClean2, extraColumn3)

## Our extra two columns are given labels.

columnNames1 <- as.character(features[,2])
columnNames2 <- append(columnNames1, c("Subject", "ActivityDescription"))

## The column names for our working data table are set.

names(buildingClean3) <- columnNames2

## We now subset our large data table so that we are left only
## with variables corresponding to means and standard deviations of measurements.

subsetData1 <- buildingClean3[, grepl("mean", names(buildingClean3))]
subsetData2 <- buildingClean3[, grepl("std", names(buildingClean3))]

## Binding these two subset operations back together in the construction of our new data table.

subsetData3 <- cbind(subsetData1, subsetData2)

## We now need to rebind our Subject and ActivityDescription columns as they
## were temporarily discarded in the above subsetting process.

subsetData4 <- cbind(subsetData3, extraColumn1)
subsetData5 <- cbind(subsetData4, extraColumn3)

## Putting the correct column labels back on again.

names(subsetData5)[ncol(subsetData5)-1]="Subject"
names(subsetData5)[ncol(subsetData5)]="ActivityDescription"

## Now we construct a new data set where the averages are taken for all remaining variables
## in our data table. These averages are taken and grouped according to Subject as well
## by ActivityDescription; thereby giving us 180 observations of averages for remaining variables,
## 6 for each of the 30 subjects.

IndependentTidyDataSetAverages <- aggregate(. ~ Subject+ActivityDescription, data = subsetData5, FUN=mean)

## Finally, this output data table is written to a file.

write.table(IndependentTidyDataSetAverages, file="IndependentTidyDataSetAverages.txt", row.names=FALSE)

