#load liabraries
library(dplyr)
library(ggplot2)
library(tidyverse)
library(lubridate)
library(readr)
library(stringr)
library(purrr)
library(broom)
library(tibble)



# Read in the data as an R Object
homicides <- homicide_data

#create new column called city_name
homicides <- homicides %>%
  unite(city_name, city, state, sep = ",", remove =FALSE )


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
  mutate(tote_unsolved = disposition == '1') %>%
  mutate(tote_unsolved = sum(tote_unsolved))%>%
  group_by(city_name, tote_unsolved)%>%
  count()%>%
  ungroup () %>%
  rename(total_homicides = n)
  
#city of Baltimore use prop.test

baltimore <- unsolved %>%
  filter(city_name == 'Baltimore,MD')%>%
  

#prop.test
prop.test(baltimore$tote_unsolved,
          baltimore$total_homicides)
#object from prop test
baltimore_pt <- prop.test(baltimore$tote_unsolved,
                          baltimore$total_homicides)

#tidy function from broom 
baltimore_pt %>%
  tidy() %>%
  select(estimate, conf.low, conf.high)

#running prop.test for all of them

test1 <- purrr::map2(unsolved$tote_unsolved,unsolved$total_homicides, 
            ~ prop.test(.x, n = .y))

unsolved <-  unsolved %>%
  mutate( sts_col = purrr::map2(unsolved$tote_unsolved,unsolved$total_homicides, 
              ~ prop.test(.x, n = .y)%>%
  {tibble(estimate =.[["estimate"]],
          CI_lower = .[["conf.int"]][[1]],
          CI_upper =.[["conf.int"]][[2]])}))%>%
  unnest()%>%
  mutate(city_name = factor (city_name, levels = city_name[order(estimate)]))%>%
  select(-estimate1)



  









  
