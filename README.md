<a id="section-two"></a>
# BELLABEAT HEALTH & WELLNESS TECHNOLOGY SMART TRACKER CASE STUDY
This document is part of the capstone project for the Google Data Analytics Certificate.
<a id="anything-you-like"></a>
## How Can a Wellness Wearable Technology Company Play it Smart?
<a id="section-two"></a>
# SUMMARY

<a id="anything-you-like"></a>
## What Are We Talking About?
Bellabeat is a wellness company and tech-driven manufacturer of health-focused smart products which offers a variety of smart devices that collect data on activity, sleep, stress, and reproductive health to empower women with knowledge about their own health and habits.

The focus of the case study is to select one Bellabeat product (the Leaf Health Fitness Tracker) and analyze smart device usage data of non-Bellabeat smart devises (Fitbit) to understand how consumers are using their smart devises.

The analytical insights of available consumer data of smart devises would reveal more growth opportunities for Bellabeat. The purpose of this data analysis may assist users to understand their habits and make better health and wellness decisions.

# ASK PHASE

<a id="anything-you-like"></a>
## Business Task
The issue is that Bellabeat is a small company with the potential to become a larger player in the global smart device market and it is looking to unlock new growth opportunities. Analyzing smart devise fitness data could help unlock new areas for growth and development. I was presented with the business task to identify trends on how consumers use non-Bellabeat smart devices to inform Bellabeat’s marketing strategy.  

<a id="anything-you-like"></a>
## The Research Questions
1.) How do consumers of Fitbit products use smart devises to gain insights into new growth opportunities for Bellabeat?

2.) What growth opportunity exist for Bellabeat based on results? 

<a id="anything-you-like"></a>
## Key Stakeholders
• Urška Sršen - Bellabeat cofounder and Chief Creative Officer 

• Sando Mur - Bellabeat cofounder and key member of Bellabeat executive team 

• Bellabeat Marketing Analytics team

# PREPARE PHASE

<a id="anything-you-like"></a>
## Dataset
The data source used for the case study is Fitbit Fitness Tracker Data. This dataset is stored in Kaggle and was made available through Möbius. The dataset contains personal fitness tracker from thirty Fitbit users. The dataset includes information about daily activity, steps, and heart rate that can be used to explore users’ habits.

Source: Mobius. April-May 2016. Fitbit Fitness Tracker Data, Version 1. Retrieved July 2022 from https://www.kaggle.com/datasets/arashnic/fitbit?resource=download

<a id="anything-you-like"></a>
## Accessibility, Data Integrity, Privacy
Verifying the metadata reveals that accessibility of the metadata usage is open-source. The author associated to the work reveals no copyright and has dedicated the work to the public domain by waiving all of his or her rights to the work worldwide under copyright law, including all related and neighboring rights. You can copy, modify, distribute, and perform the work, even for commercial purposes, all without asking permission.

<a id="anything-you-like"></a>
## Information About the Dataset
Respondents generated this dataset to a distributed survey via Amazon Mechanical Turk between 03.12.2016-05.12.2016. Thirty eligible Fitbit users consented to the submission of personal tracker data, including minute-level output for physical activity, heart rate, and sleep monitoring. The variation between output represents the use of different types of Fitbit trackers and individual tracking behaviors and preferences. The dataset includes information about daily activity, steps, and heart rate that we can use to explore users’ habits.

<a id="anything-you-like"></a>
## Data Organization, Sorting, Verification
Data Organization. The Fitabase data folder contains 18 .CSV files that provides quantitative information which includes daily activity, calories, intensities, steps, heartrate, sleep, and weight log. The spreadsheet contains data of each uniquely identified subject in multiple rows based on activity date. The data is considered a long format since there is one observation row per subject where each subject will have data in multiple rows. Each user has a unique ID with multiple rows of data for each tracked by day and time.


Verification. I first converted the files from .CSV to Excel for ease of data organization because upon opening certain files the spreadsheets indicated that certain .CSV files contained data with over 1.3 million rows. Tables in Apple Numbers application for .CSV files cannot support more than one million rows. Thus, I used Excel to sort the sample and filtered the tables using Pivot Tables. I verified attributes, observations, and relations between each table. I counted the sample size (number of users) and verified the analysis of the length of time as 31 days. 

<img width="855" alt="AA_Summary Files" src="https://user-images.githubusercontent.com/113868202/193727398-42b0ed23-a52f-49c7-b657-49638504058f.png">

<a id="anything-you-like"></a>
## Limitations
A limitation of a sampling bias could be presented due to the small size resulting between 8 users (minimum) to 33 users (maximum) and lack of demographic information. The dataset does not reveal whether the sample is representative of the whole population. Another potential issue is the relevancy of the information could be outdated since the scope of the data set reveals information from 2016 within a three-month time frame, March to May. Our case study entails an operational approach tapping into data to extract valuable insights.

<a id="section-two"></a>
# PROCESS PHASE

I analyzed the data using R due to the vast amount of data, accessibility, and the ability to create data visualization to share the results with the stakeholders. 

<a id="anything-you-like"></a>
## Initial Cleaning Process
The unzipped dataset was first downloaded as a .CSV file. I then used Excel to take a first look at the dataset. Upon previewing the dataset, I noticed that one column had the date and time combined in each cell. I cleaned the spreadsheets by splitting the value into a separate date and time column using the integer (INT) function. I used pivot tables to count the unique identifications and to explore the range of dates. I transformed the data from Excel to .CSV so I can work with it effectively in RStudio.

<a id="anything-you-like"></a>
## Installing Packages and Opening Libraries
I continued my analysis in R and chose the following package tools to assist in the analysis.

Packages: tidyverse, here, skimr, janitor, dplyr, lubridate, ggpubr, ggrepel

    >install.packages("tidyverse")
    >library(tidyverse)
    >library(here)
    >library(skimr)
    >library(lubridate)

<a id="anything-you-like"></a>
## Importing Datasets
After reviewing the datasets, I used appropriate file-naming conventions and renamed the files. I uploaded the datasets that will help answer the business task. For the analysis, I focus on the following datasets:


•  Daily_Activity 

•  Daily_Sleep 

•  Daily_Intensities 


Note: The weight (8 Users) and heart rate (7 users) data files was excluded from the analysis due to its small sample size.


<a id="anything-you-like"></a>
## Previewing the Datasets
I previewed the data frames in the environment pane and reviewed the summary of each column using the codes: head(filename), str(filename), skim_without_charts(filename)

The Daily_Activity dataset showed a data frame containing 940 rows and 15 columns. 

The Daily_Sleep dataset showed a data frame containing 413 rows and 6 columns. 

The Daily_Intensities dataset showed a data frame containing 940 rows and 10 columns.

<a id="anything-you-like"></a>
## Secondary Cleaning and Formatting Process
I cleaned the column names to make sure the column names were consistent.

    >head(Daily_Activity)
    >library(janitor)
    >rename_with(Daily_Activity, tolower)

    >head(Daily_Intensities)
    >library(janitor)
    >rename_with(Daily_Intensities, tolower)

    >head(Daily_Sleep)
    >library(janitor)
    >rename_with(Daily_Sleep, tolower)


    >clean_names(Daily_Activity)
    >Daily_Activity<- rename_with(Daily_Activity, tolower)

    >clean_names(Daily_Sleep)
    >Daily_Sleep<- rename_with(Daily_Sleep, tolower)

    >clean_names(Daily_Intensities)
    >Daily_Intensities<- rename_with(Daily_Intensities, tolower)
 
I reviewed how many unique users of the smart devices existed per data frame using the n_unique(), taby(), and dplyr functions. The sample size range was: 24 to 33.

•  Activity = 33

•  Sleep = 24

•  Intensities = 33

    >n_unique(Daily_Activity$id)
    >n_unique(Daily_Sleep$id)
    >n_unique(Daily_Intensities$id)
    
    >library(dplyr) Daily_Activity %>% count(id)
    >library(dplyr) Daily_Sleep %>% count(id)
    >library(dplyr) Daily_Intensities %>% count(id)

RESULTS:

sum(duplicated(Daily_Activity))
[1] 0

sum(duplicated(Daily_Sleep))
[1] 3

sum(duplicated(Daily_Intensities))
[1] 0


    >sum(duplicated(Daily_Activity))
    >sum(duplicated(Daily_Sleep))
    >sum(duplicated(Daily_Intensities))
 
The original value of Daily_Sleep returned 413 rows with 3 duplicates. Therefore, I removed the duplicates.
 
    >Daily_Sleep <- Daily_Sleep %>% distinct() %>% drop_na()
    
I re-tested and verified that the duplicates were removed from Daily_Sleep. The new data frame reveals: 
Original Dataset for Daily_Sleep had 413 rows. New Dataset for Daily_Sleep has 410 rows.

RESULTS:

head(Daily_Sleep)

id date time totalsleeprecords

1 1503960366 4/12/16 12:00:00 AM 1

2 1503960366 4/13/16 12:00:00 AM 2

3 1503960366 4/15/16 12:00:00 AM 1

4 1503960366 4/16/16 12:00:00 AM 2

5 1503960366 4/17/16 12:00:00 AM 1

6 1503960366 4/19/16 12:00:00 AM 1

totalminutesasleep totaltimeinbed

1 327 346

2 384 407

3 412 442

4 340 367

5 700 712

6 304 320

sum(duplicated(Daily_Sleep))

[1] 0

    >head(Daily_Sleep)
    >sum(duplicated(Daily_Sleep))
    
    >head(Daily_Activity)
    >colnames(Daily_Activity)

    >head(Daily_Sleep)
    >colnames(Daily_Sleep)

    >head(Daily_Intensities)
    >colnames(Daily_Intensities)

<a id="anything-you-like"></a>
## Summary Statistics
I was interested in reviewing summary statistics of each data frame.  I analyzed how many distinct users participated in each data frame. The results revealed that there may be more participants in the daily activity and intensities datasets than in the sleep dataset. Daily_Activity had 33 participants, Daily_Sleep (24), and Daily_Intensity (33).


RESULTS:

n_distinct(Daily_Activity$id)

[1] 33

n_distinct(Daily_Sleep$id)

[1] 24

n_distinct(Daily_Intensities$id)

[1] 33
> 

nrow(Daily_Activity)

[1] 940

nrow(Daily_Sleep)

[1] 410

nrow(Daily_Intensities)

[1] 940

I looked to see how many observations (rows) were presented in each data frame. The results revealed that Daily_Activity and Daily_Intensities have an equal number of rows (940) and Daily_Sleep has the least number of rows (410). The R programming assists in handling big datasets. Activity (940 rows), Sleep (410), and Intensities (940).

    >n_distinct(Daily_Activity$id)
    >n_distinct(Daily_Sleep$id)
    >n_distinct(Daily_Intensities$id)
    
    >nrow(Daily_Activity)
    >nrow(Daily_Sleep)
    >nrow(Daily_Intensities)
        
The statistics reveal for the sample of people’s daily activities, sleep, and intensities, that the average total step for daily activities is 7638, the average total distance is 5.5, and the average sedentary minutes is 991 minutes or approximately 16 hours.

The statistics reveal for the sample of people’s daily sleep patterns, the average total minutes asleep is 419 minutes or approximately 7 hours and the average total time in bed is 458 minutes or approximately 8 hours in bed.

The statistics reveal for the sample study of people’s daily intensity routine, that the averages were calculated based on three types of activities: lightly active, fairly active, and very active. The statistics show an average of 192 minutes or approximately 3.2 hours of a lightly active intense routine; an average of approximately 14 minutes of a fairly actively intense activity; and an average of 21 minutes of a very active intense routine.

RESULTS:

  Daily_Activity %>%

  • select(totalsteps,
  • totaldistance,
  • sedentaryminutes) %>%
  • summary() totalsteps totaldistance sedentaryminutes Min. : 0 Min. : 0.000 Min. : 0.0
    1st Qu.: 3790 1st Qu.: 2.620 1st Qu.: 729.8
    Median : 7406 Median : 5.245 Median :1057.5
    Mean : 7638 Mean : 5.490 Mean : 991.2
    3rd Qu.:10727 3rd Qu.: 7.713 3rd Qu.:1229.5
    Max. :36019 Max. :28.030 Max. :1440.0
    
  Daily_Sleep %>%

  • select(totalsleeprecords,
  • totalminutesasleep,
  • totaltimeinbed) %>%
  • summary() totalsleeprecords totalminutesasleep totaltimeinbed Min. :1.00 Min. : 58.0 Min. : 61.0
    1st Qu.:1.00 1st Qu.:361.0 1st Qu.:403.8
    Median :1.00 Median :432.5 Median :463.0
    Mean :1.12 Mean :419.2 Mean :458.5
    3rd Qu.:1.00 3rd Qu.:490.0 3rd Qu.:526.0
    Max. :3.00 Max. :796.0 Max. :961.0

  Daily_Intensities %>%

  • select(lightlyactiveminutes,
  • fairlyactiveminutes,
  • veryactiveminutes) %>%
  • summary() lightlyactiveminutes fairlyactiveminutes veryactiveminutes Min. : 0.0 Min. : 0.00 Min. : 0.00
    1st Qu.:127.0 1st Qu.: 0.00 1st Qu.: 0.00
    Median :199.0 Median : 6.00 Median : 4.00
    Mean :192.8 Mean : 13.56 Mean : 21.16
    3rd Qu.:264.0 3rd Qu.: 19.00 3rd Qu.: 32.00
    Max. :518.0 Max. :143.00 Max. :210.00

    >Daily_Activity %>%
    >select(totalsteps, totaldistance, sedentaryminutes) %>% summary()

    >Daily_Sleep %>%
    >select(totalsleeprecords, totalminutesasleep, totaltimeinbed) %>% summary()

    >Daily_Intensities %>%
    >select(lightlyactiveminutes, fairlyactiveminutes, veryactiveminutes) %>% summary()

I was curious to see the sedentary minutes of the participants in connection to the number of steps taken in a day since many people spend large amounts of time sitting or lying down at work, home, or school. I was looking for a negative relationship between a sedentary lifestyle and daily steps. The results reveal that the more time people spent in an inactive stage the less steps that were taken daily. The regression line inclines downward. Therefore, using Bellabeat smart devises can help customers stay on track in taking more steps in the day and reduce the amount of inactivity.

![Daily Activities_TotalSteps and SedentaryMinutes](https://user-images.githubusercontent.com/113868202/193733308-60ce32ac-5381-4043-8ac3-5abf01938570.png)

    >ggplot(data=Daily_Activity, aes(x=totalsteps, y=sedentaryminutes)) + geom_point() + geom_smooth(method = "lm", se = FALSE) + labs(x =
    "totalsteps", y = "sedentaryminutes", title = "Daily Activities: Total Steps and Sedentary Minutes")+ theme_minimal()

I also analyzed the total number of steps for a very active person. The results reveal that the more time people spent in a very active stage the greater the steps taken daily. The visuals reveal that using smart devises can help customers remain active which may increase the number of steps for a healthier lifestyle.

![Daily Activities_TotalSteps and VeryActiveMinutes](https://user-images.githubusercontent.com/113868202/193734121-5332a20f-237a-42b7-9a1b-47faef2c499e.png)

    >ggplot(data=Daily_Activity, aes(x=totalsteps, y=veryactiveminutes)) + geom_point() + geom_smooth(method = "lm", se = FALSE) + labs(x =
    "totalsteps", y = "veryactiveminutes", title = "Daily Activities: Total Steps and Very Active Minutes")+ theme_minimal()

We can also note that sedentary time is not necessarily connected to the number of calories burned. The results also reveal that generally, calories trend positively with total steps taken.

![Relationship bet steps taken in a day and sedentary minutes](https://user-images.githubusercontent.com/113868202/193734285-ce31c5d1-4b0a-4ac8-a292-8d0e8535723d.png)

    >ggplot(data=Daily_Activity, aes(x=totalsteps, y=sedentaryminutes, color = calories)) + geom_point() + labs(title = "Relationship: Daily Steps &
    Sedentary Minutes")

I analyzed the relationship between minutes asleep and the time in bed which I suspected would be completely linear. The results revealed an average trending time frame of time in bed and minutes asleep to be approximately between 7 to 8 hours. The BellaBeat products can be helpful to monitor the amount of sleep a consumer has per day and help balance the amount of time in bed.

![Daily Sleep_TotalMinAsleep and TotalTimeinBed](https://user-images.githubusercontent.com/113868202/193734441-74a6e5cf-1f5e-42e3-99ba-96af8021f71d.png)

    >ggplot(data=Daily_Sleep, aes(x=totalminutesasleep, y=totaltimeinbed)) + geom_point() + geom_smooth(method = "lm", se = FALSE) + labs(title = "Daily     
    Sleep: Total Minutes Asleep and Total Time in Bed")

In addition, the following graph reveals certain outliers indicating that some of the data points spent a lot of time in bed but did not particularly sleep and a small batch that slept a lot (approximately between 3 to 9 hours) and spent more time in bed.

![Relationship_TotalMinAsleep_TotalTime](https://user-images.githubusercontent.com/113868202/193734721-fde947e8-fde2-4321-bd7c-45b6d49de416.png)

    >ggplot(data=Daily_Sleep, aes(x=totalminutesasleep, y=totaltimeinbed)) + geom_point(aes(color=date))
    
The analysis revealed that when the user was very active per minute the user was also very active at a greater distance. Thus, when the user was not very active, the users did not walk further or was very active at a greater distance.

![Very Active Daily Intensities by Distance and Minutes](https://user-images.githubusercontent.com/113868202/193734843-39103fb5-e7b0-4e02-a992-cc1025aebb08.png)

    >ggplot(data=Daily_Intensities, aes(x=veryactivedistance, y=veryactiveminutes)) + geom_point() + geom_smooth(method = "lm", se = FALSE) + labs(title =
    "Very Active Daily Intensities by Distance and Minutes")

I merged the following datasets to analyze any correlation between the variables, used ‘id’ as a primary component, and looked at how many participants are in this merged dataset.

    >SleepandActivity <- merge(Daily_Sleep, Daily_Activity, by="id")
    >head(SleepandActivity)

    >ActivityandIntensities <- merge(Daily_Activity, Daily_Intensities, by="id")
    >head(ActivityandIntensities)

    >SleepandIntensities <- merge(Daily_Sleep, Daily_Intensities, by="id")
    >head(SleepandIntensities)
 
I explored different relationships between sleep and activity.
 
    >x <- c(3,3,2,1,1)
    >labels <- c('veryactivedistance','moderatelyactivedistance','lightactivedistance','Sedentaryactivedistance')
    pie(x, labels, main="Sleep and Activity", col=rainbow(length(x)))

The results also revealed that participants who sleep more (approximately  250 to 550 minutes or 4 to 9 hours), also take more steps per day. There appears to be a relationship between the amount of activity and sleep. Using Bellabeat’s leaf bracelet, necklace, or clip, as well as the wellness watch products can help users track  their activity and sleep regimen.

![SleepandActivity_Total Steps and Time in Bed](https://user-images.githubusercontent.com/113868202/193735235-0ea35715-230d-458c-917b-8b1acf9eafef.jpg)

    >ggplot(data=SleepandActivity, aes(x=totaltimeinbed, y=totalsteps, col=date()))+ geom_point() + geom_col() + labs(title = "Sleep and Activity: Total
    Steps and Time in Bed")
    
<a id="section-three"></a>
# ACT PHASE (CONCLUSION) 
The following recommendations may assist the marketing campaign strategy and improve the Bellabeat app: 

• Expand product for teleservices. Bellabeat can include medical IoT such as the adoption of cloud services and integrated apps which allows people to manage their health and healthcare experts can monitor their patients remotely which reduces the need for in-person appointments.

• Expand areas to include Mental Health. Digital Wellness Apps on mindfulness, meditation, digital therapy, mental health self-care. Bellabeat can include scheduling apps and software to allow for a broader adaptation of teletherapy.

• Expanding to wider audience. Include Bellabeat products for male gender users. Future analysis can then include a comparative analysis between male and female smart device uses.

<a id="section-three"></a>
# ADDITIONAL NOTES

I am grateful to contribute to knowledge production. Thank you for reading. Happy analysis! 🤓📊📈
