---
title: "CodeBook.md"
author: "Jeremy Huang"
date: "Saturday, February 14, 2015"
output: html_document
---
This is how my run_analysis.R run to clean up the data:

1. Set the working directory to the directory where the source data were 
   downloaded and unzipped.
2. Read in the training set and test set source data using features.txt
   as variable names of the data frames.
3. Using dplyr package, add actcode (activity code which represents one of 
   the six activities) and subject_id (representing the subject who perform
   the activity) to the training and test data frames.
4. Merge the training and test data frame horizontally as required. The 
   merged data frame has 10299 observations and 563 variables.
5. Step 2: extract the columns with "mean()" and "std()" based on the 
   data frame read from features.txt.
6. Step 3: read in the description of activity code (activity_label.txt) 
   and merge to data frame by the actcode. So each observation has a column
   describing the activity. But the column name remains V2 which is 
   meaningless.
7. Step 4: rename the column name of "V2"" to "activity"" which is meaningful
   and delete the redundant column "actcode".
8. Step 5: group by "subject_id" and "activity" and through summarise_each 
   function to get a new data frame which has avarage values for each 
   measurement for each "subject_id" and "activity". The clean data set has
   180 observations and 563 variables.

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
