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
                                  '0' = 'Closed by arrest '))%>%
  group_by(city_name)%>%
  mutate(total_homicides = n()) %>%
  mutate(unsolved = disposition == '1') %>%
  mutate(unsolved = sum(unsolved))%>%
  group_by(city_name, unsolved)%>%
  count()%>%
  ungroup () %>%
  rename(total_homicides = n)
  
#city of Baltimore use prop.test

baltimore <- unsolved %>%
  filter(city_name == 'Baltimore,MD')

#prop.test
prop.test(baltimore$unsolved,
          baltimore$total_homicides)
#object from prop test
baltimore_pt <- prop.test(baltimore$unsolved,
                          baltimore$total_homicides)









  
