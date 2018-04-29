library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(googleVis)
library(leaflet)
library(data.table)

#read in file
crime_dt = read.csv('c:\\users\\chris\\csv files\\nypd_crime_2016_1.csv')

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

crime_time = crime %>%
  group_by(., cmplnt_fr_tm) %>%
  summarise(sum(code))

choice <- unique(crime$code)


# #Bar chart of crimes committed per borough
# boro_plot = ggplot(data = crime, aes(x = crime$boro_nm, y = crime$code)) +
#   geom_bar(stat = 'identity') +
# labs(title = 'Crimes per Borough',
#        x = 'Borough',
#        y = 'Crime by desc code') +
#   scale_color_brewer(palette = 'Blues')
# 
# # Plot of
# 
# 
# #Selecting the top 20 crimes
# top_crimes <- crime %>%
#   group_by(code) %>%
#   summarise(count=n()) %>%
#   select(crime$code) %>%
#   top_n(20, count)
# 
# #Bar chart of top 20 crimes
# top_crimes_plot = ggplot(data = top_crimes, aes(x = top_crimes$code, y = top_crimes$count)) +
#   geom_bar(stat = 'identity') +
#   labs(title = 'Top 20 Crimes',
#        x = 'Offense Code',
#        y = 'Offense Count') +
#   scale_color_brewer(palette = 'Blues')


