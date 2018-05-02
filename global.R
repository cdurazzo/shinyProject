library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(leaflet)
library(data.table)

#read in file
crime_dt = read.csv('c:\\users\\chris\\csv files\\nypd_crime_2016_1.csv')

crime_table = data.table::data.table(crime)

#Put column names in lowercase
colnames(crime_dt) = tolower(colnames(crime_dt))

#Put date in date form
crime_dt$cmplnt_fr_dt <- as.Date(crime_dt$cmplnt_fr_dt, '%m/%d/%Y')

## Filter out bad values
crime_dt = filter(.data = crime_dt, (crime_dt$ofns_desc !=  "OTHER STATE LAWS (NON PENAL LA"), (crime_dt$ofns_desc !=  "LOITERING/GAMBLING (CARDS, DIC"), (crime_dt$ofns_desc != ""))

#Assign values to each unique crime description
offense_descriptions = unique(crime_dt$ofns_desc)
new_df = data.frame(ofns_desc = offense_descriptions, code = 1:length(offense_descriptions))

#Join old and new df's
crime = left_join(crime_dt, new_df)

pop_data = data.frame(boro_nm = c('BRONX', 'BROOKLYN','MANHATTAN', 'QUEENS', 'STATEN ISLAND'),
                      pop  = c(1455720, 2629150, 1643734, 2333054, 476015),
                      sq_mi= c(42, 71, 22.83, 109, 58.5),
                      pop_sm = c(34653, 37137, 72033, 21460, 8112))

crime_df = left_join(crime, pop_data)

crime_time = crime %>%
  group_by(., cmplnt_fr_tm) %>%
  summarise(sum(code))

choice <- unique(crime$ofns_desc)

