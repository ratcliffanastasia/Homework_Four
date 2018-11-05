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
  unite(city_name, city, state, sep = ",", remove =FALSE )



#new dataframe
#one row per city that gives total homicides 
#one row number of unsolved homicides 
unsolved <- homicides %>%
  select(city_name, disposition) %>%
  mutate(unsolved_homicides =  str_extract(disposition, "Closed without arrest|Open/No arrest"))%>%
  group_by(city_name, disposition, unsolved_homicides)%>%
  count(city_name)
 
    
   
  

  
  
  
  

  
  ?maps2









#city of Baltimore use prop.test
  
