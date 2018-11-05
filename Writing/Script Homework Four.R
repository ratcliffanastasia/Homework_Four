#load liabraries
library(dplyr)
library(ggplot2)
library(tidyverse)
library(lubridate)
library(readr)
library(stringr)
library(purrr)
library()



# Read in the data as an R Object
homicides <- homicide_data

#create new column called city_name
homicides <- homicides %>%
  unite(city_name, city, state, sep = ",", remove =FALSE )%>%


#new dataframe
#one row per city that gives total homicides 

#one row number of unsolved homicides 
unsolved <- homicides %>%
  select(city_name, disposition)%>%
  mutate(disposition = factor(disposition))%>%
  mutate(disposition = fct_recode(disposition, '1' = 'Closed without arrest',
                                  '1'= 'Open/No arrest',
                                  '0' = 'Closed by arrest '))
  









#city of Baltimore use prop.test
  
