## INSTALL PACKAGES & LIBRARIES

install.packages("tidyverse")
library(tidyverse)
library(here)
library(skimr)
library(lubridate)
library(ggplot2)

# Cleans column names
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


# Count number of users by column:
n_unique(Daily_Activity$id)
n_unique(Daily_Sleep$id)
n_unique(Daily_Intensities$id)

# Returns a data frame with counts:
tabyl(Daily_Activity, id)
tabyl(Daily_Sleep, id)
tabyl(Daily_Intensities, id)

# Count number of times a value appears in a column:
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

# Remove Duplicates:
Daily_Activity <- Daily_Activity %>%
  distinct() %>%
  drop_na()

Daily_Sleep <- Daily_Sleep %>%
  distinct() %>%
  drop_na()

Daily_Intensities <- Daily_Intensities %>%
  distinct() %>%
  drop_na()


# Check the cleaned datasets:
head(Daily_Activity)
head(Daily_Sleep)
head(Daily_Intensities)

# Recheck and verify the duplicates were removed:
sum(duplicated(Daily_Sleep))

# Review and identify all columns:
head(Daily_Activity)
colnames(Daily_Activity)

head(Daily_Sleep)
colnames(Daily_Sleep)

head(Daily_Intensities)
colnames(Daily_Intensities)

# Distinct Users
n_distinct(Daily_Activity$id)
n_distinct(Daily_Sleep$id)
n_distinct(Daily_Intensities$id)


# Number of rows (observations)
nrow(Daily_Activity)
nrow(Daily_Sleep)
nrow(Daily_Intensities)


# Summary Statistics

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


# Relationship between steps taken in a day and sedentary minutes 

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


# Relationship between minutes asleep and time in bed 

ggplot(data=Daily_Sleep, aes(x=totalminutesasleep, y=totaltimeinbed)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Daily Sleep: Total Minutes Asleep and Total Time in Bed")


# Areas to explore further

ggplot(data=Daily_Intensities, aes(x=veryactivedistance, y=veryactiveminutes)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Very Active Daily Intensities by Distance and Minutes")

  
# Merging Datasets 
  
SleepandActivity <- merge(Daily_Sleep, Daily_Activity, by="id")
head(SleepandActivity)

ActivityandIntensities <- merge(Daily_Activity, Daily_Intensities, by="id")
head(ActivityandIntensities)

SleepandIntensities <- merge(Daily_Sleep, Daily_Intensities, by="id")
head(SleepandIntensities)


# How many participants in data set

n_distinct(SleepandActivity$id)
n_distinct(ActivityandIntensities$id)
n_distinct(SleepandIntensities$id)
n_distinct(DailyData$Id)


# Other relationships after merging 

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
