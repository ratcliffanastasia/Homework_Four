# Read in the data as an R Object
homicides <- homicide_data

#create new column called city_name
homicides <- homicides %>%
  unite(city_name, city, state, sep = ",", remove =FALSE )

#new dataframe
#one row per city that gives total homicides 
#one row number of unsolved homicides 
unsolved <- homicides %>%
  select(city_name, disposition)



#city of Baltimore use prop.test
  
