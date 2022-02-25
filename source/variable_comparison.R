#A3 - Tom Jubin - variable comparison

library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)

incarcerations_table <- read_incarcerations_trends()

cleandata <- incarcerations_table %>%
  mutate(Year = year, Female_Jail_Population_Age_15_64 = female_pop_15to64, Male_Jail_Population_Age_15_64 = male_pop_15to64) %>%
  select(Year, Female_Jail_Population_Age_15_64, Male_Jail_Population_Age_15_64)

comparison <- ggplot(data=cleandata, aes(x=Year))+
  geom_line(aes(y = Female_Jail_Population_Age_15_64), color = "green") +
  geom_line(aes(y = Male_Jail_Population_Age_15_64), color = "purple") +
  labs(title = "Female vs Male Age 15-64 Jail Population", x = "Year", y = "Population")

ggplotly(comparison)

#Signifcant Values

max_female_15_64 <- cleandata %>%
  filter(Female_Jail_Population_Age_15_64 == max(Female_Jail_Population_Age_15_64, na.rm=TRUE)) %>%
  pull(Female_Jail_Population_Age_15_64)
  #2015

max_male_15_64 <- cleandata %>%
  filter(Male_Jail_Population_Age_15_64 == max(Male_Jail_Population_Age_15_64, na.rm=TRUE)) %>%
  pull(Male_Jail_Population_Age_15_64)
  #2016
