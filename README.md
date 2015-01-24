# CleanDataProject

## Ensure

Script assumes that the raw dataset obtainable from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
has been unzipped into the current working directory containing the 'run_analysis.R' script.

## Script Process

The script proceeds by putting together the various pieces of data from the appropriate
files into a single large data frame.

From here, the single large data frame is subsetted in that only the variables
corresponding to means and standard deviations of measurements are retained into a new, smaller data frame.

There is a brief interlude where the 'Subject' and 'ActivityDescription' columns are re-appended to
the end of the new data frame.

Finally, averages of all remaining variables are taken and grouped by subject as well as according to
the type of activity being undertaken. This results in a final data frame containing 180 observations;
6 for each of the 30 subjects according to type of activity.

## Final Table

This final table can be observed by downloading the
IndependentTidyDataSetAverages.txt
file as uploaded in the project submission into your current working directory.
From there, running the following command in R will provide a view of the final table:

TidyDataSet <- read.table("IndependentTidyDataSetAverages.txt", header=TRUE)

View(TidyDataSet)