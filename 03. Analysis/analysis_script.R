## UPLOAD YOUR CSV FILES TO R
# Write code in this editor box instead of in the console.

## INSTALL COMMON PACKAGES & LIBRARIES

install.packages("tidyverse")
library(tidyverse)

# Load CSV files and import dataset from environment pane or files tab. 
library(here)
library(skimr)
library(lubridate)

# Janitor package automatically cleans column names
head(Daily_Activity)
library(janitor) 
rename_with(Daily_Activity, tolower)

head(Daily_Intensities)
library(janitor)
rename_with(Daily_Intensities, tolower)

head(Daily_Sleep)
library(janitor)
rename_with(Daily_Sleep, tolower)

clean_names(Daily_Activity)
Daily_Activity<- rename_with(Daily_Activity, tolower)

clean_names(Daily_Sleep)
Daily_Sleep<- rename_with(Daily_Sleep, tolower)

clean_names(Daily_Intensities)
Daily_Intensities<- rename_with(Daily_Intensities, tolower)


# To count the actual number of users by column:
n_unique(Daily_Activity$id)
n_unique(Daily_Sleep$id)
n_unique(Daily_Intensities$id)

# Returns a data frame with counts:

tabyl(Daily_Activity, id)
tabyl(Daily_Sleep, id)
tabyl(Daily_Intensities, id)

# To count the number of times a value appears in a column in R:

library(dplyr)
Daily_Activity %>%
  count(id)

library(dplyr)
Daily_Sleep %>%
  count(id)

library(dplyr)
Daily_Intensities %>%
  count(id)


# Clean for Duplicates:

sum(duplicated(Daily_Activity))
sum(duplicated(Daily_Sleep))
sum(duplicated(Daily_Intensities))

# Remove the Duplicates:

Daily_Activity <- Daily_Activity %>%
  distinct() %>%
  drop_na()

Daily_Sleep <- Daily_Sleep %>%
  distinct() %>%
  drop_na()

Daily_Intensities <- Daily_Intensities %>%
  distinct() %>%
  drop_na()


# Check one last time the cleaned datasets:

head(Daily_Activity)
head(Daily_Sleep)
head(Daily_Intensities)

# Recheck and verify the duplicates were removed:

sum(duplicated(Daily_Sleep))


### PREVIEWS AND SUMMARIES

# Review and identify all columns:

head(Daily_Activity)
colnames(Daily_Activity)

head(Daily_Sleep)
colnames(Daily_Sleep)

head(Daily_Intensities)
colnames(Daily_Intensities)


### UNDERSTANDING SUMMARY STATISTICS

# Distinct Users

n_distinct(Daily_Activity$id)
n_distinct(Daily_Sleep$id)
n_distinct(Daily_Intensities$id)


# Number of rows (observations)

nrow(Daily_Activity)
nrow(Daily_Sleep)
nrow(Daily_Intensities)


# Quick Summary Statistics for activity dataframe:

Daily_Activity %>%  
  select(totalsteps,
         totaldistance,
         sedentaryminutes) %>%
  summary()

++++++++++++++++++
  
  Daily_Sleep %>%  
  select(totalsleeprecords,
         totalminutesasleep,
         totaltimeinbed) %>%
  summary()

++++++++++++++++++
  
  Daily_Intensities %>%  
  select(lightlyactiveminutes,
         fairlyactiveminutes,
         veryactiveminutes) %>%
  summary()


# What's the relationship between steps taken in a day and sedentary minutes? 
# How could this help inform the customer segments that we can market to? 
# E.g. position this more as a way to get started in walking more? 
# Or to measure steps that you're already taking?

ggplot(data=Daily_Activity, aes(x=totalsteps, y=sedentaryminutes)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "totalsteps",
       y = "sedentaryminutes",
       title = "Daily Activities: Total Steps and Sedentary Minutes")+
  theme_minimal()

+++++++++++++++++++++++++++
  
  ggplot(data=Daily_Activity, aes(x=totalsteps, y=veryactiveminutes)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "totalsteps",
       y = "veryactiveminutes",
       title = "Daily Activities: Total Steps and Very Active Minutes")+
  theme_minimal()


# What's the relationship between minutes asleep and time in bed? 
# You might expect it to be almost completely linear - are there any unexpected trends?

ggplot(data=Daily_Sleep, aes(x=totalminutesasleep, y=totaltimeinbed)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Daily Sleep: Total Minutes Asleep and Total Time in Bed")


# What could these trends tell you about how to help market this product? 
# Or areas where you might want to explore further?

ggplot(data=Daily_Intensities, aes(x=veryactivedistance, y=veryactiveminutes)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Very Active Daily Intensities by Distance and Minutes")

++++++++++++++++++++++
  
  # MERGING TWO DATASETS
  
  SleepandActivity <- merge(Daily_Sleep, Daily_Activity, by="id")
head(SleepandActivity)

ActivityandIntensities <- merge(Daily_Activity, Daily_Intensities, by="id")
head(ActivityandIntensities)

SleepandIntensities <- merge(Daily_Sleep, Daily_Intensities, by="id")
head(SleepandIntensities)

DailyData <- merge(Daily_Activity, Daily_Sleep, by=c ("id", "date"))
glimpse(DailyData)

# Look at how many participants are in this data set.

n_distinct(SleepandActivity$id)
n_distinct(ActivityandIntensities$id)
n_distinct(SleepandIntensities$id)
n_distinct(DailyData$Id)


# Other relationships after merging charts

ggplot(data=SleepandActivity, aes(x=totaltimeinbed, y=totalsteps, col=date()))+
  geom_point() + geom_col() +
  labs(title = "Sleep and Activity: Total Steps and Time in Bed")

ggplot(data=SleepandActivity, aes(x=totalminutesasleep, y=totalsteps, col="minutes"))+
  geom_point() + geom_col() +
  labs(title = "Sleep and Activity: Total Steps and Minutes Asleep")

ggplot(data=ActivityandIntensities, aes(x=totalsteps, y=totaldistance, col="minutes"))+
  geom_point() + geom_col() +
  labs(title = "Activity and Intensities: Total Steps and Distance")

x <- c(3,3,2,1,1)
labels <- c('veryactivedistance','moderatelyactivedistance','lightactivedistance','Sedentaryactivedistance')
pie(x, labels, main="Sleep and Activity", col=rainbow(length(x)))

# GREAT ONE:
ggplot(data=Daily_Activity, aes(x=totalsteps, y=sedentaryminutes, color = calories)) + 
  geom_point() +
  labs(title = "Relationship: Daily Steps & Sedentary Minutes")

ggplot(data=Daily_Sleep, aes(x=totalminutesasleep, y=totaltimeinbed)) + 
  geom_point(aes(color=date)) 

ggplot(data=Daily_Activity, aes(x=totalsteps, y=sedentaryminutes, col="red")) + 
  geom_point() +
  labs(title = "Total Steps and Sedentary Minutes of Daily Activities")

ggplot(data=Daily_Activity, aes(x=totalsteps, y=veryactiveminutes)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Daily Activities: Total Steps and Very Active Minutes")


######## THIS IS EXTRA CODES #############
# To return info about the rows(observations) and columns(variables) plus extra info:

str(Daily_Activity)
str(Daily_Sleep)
str(Hourly_Steps)

# To get summaries of our data frame:

skim_without_charts(Daily_Activity)
skim_without_charts(Daily_Sleep)
skim_without_charts(Hourly_Steps)

# glimpse()

glimpse(Daily_Activity)
glimpse(Daily_Sleep)
glimpse(Hourly_Steps)

# To view a particular column: 

Daily_Activity %>%
  select(Id)

Daily_Sleep %>%
  select(Id)

Hourly_Steps %>%
  select(Id)

# If you want to view everything minus the particular column:

Daily_Activity %>%
  select(- Id)

# To rename a column:

Daily_Activity %>%
  rename(Date=ActivityDate) %>%
  
# To change column names to upper or lower case:
  
rename_with(Daily_Activity, tolower)
rename_with(Daily_Sleep, tolower)
rename_with(Daily_Sleep, toupper)

# To create visualizations 
library(ggplot2)