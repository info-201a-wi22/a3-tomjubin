## A3 - Analysis.R - Tom Jubin


ibrary(ggplot2)
library(dplyr)
library(reshape2)
library(plotly)

incarcerations_table <- read_incarcerations_trends()

cleandata1 <- incarcerations_table %>%
  mutate(Year = year, Total_Black_Jail_Population = black_jail_pop, Total_White_Jail_Population = white_jail_pop, Total_Jail_Population = total_jail_pop) %>%
  select(Year, Total_Black_Jail_Population, Total_White_Jail_Population, Total_Jail_Population)

time_graph <- ggplot(data=cleandata1, aes(x=Year))+
  geom_line(aes(y = Total_Jail_Population), color = "yellow") +
  geom_line(aes(y = Total_Black_Jail_Population), color = "black") +
  geom_line(aes(y = Total_White_Jail_Population), color = "white") + 
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Total vs Black vs White Jail Population ", 
       x = "Year", 
       y = "Population")

ggplotly(time_graph)

#Signficant Values

max_black_jail_pop <- cleandata1 %>%
  filter(Total_Black_Jail_Population == max(Total_Black_Jail_Population, na.rm=TRUE)) %>%
  pull(Total_Black_Jail_Population)
 
max_white_jail_pop_during_max_black_jail_pop <- cleandata1 %>%
  filter(Year == 1993) %>%
  filter(Total_White_Jail_Population == max(Total_White_Jail_Population, na.rm=TRUE)) %>%
  pull(Total_White_Jail_Population) 

total_jail_pop_during_max_black_jail_pop <- cleandata1 %>%
  filter(Year == 1993) %>%
  filter(Total_Jail_Population == max(Total_Jail_Population, na.rm = TRUE)) %>%
  pull(Total_Jail_Population)

####################################################

library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)

cleandata2 <- incarcerations_table %>%
  mutate(Year = year, Female_Jail_Population_Age_15_64 = female_pop_15to64, Male_Jail_Population_Age_15_64 = male_pop_15to64) %>%
  select(Year, Female_Jail_Population_Age_15_64, Male_Jail_Population_Age_15_64)

comparison <- ggplot(data=cleandata2, aes(x=Year))+
  geom_line(aes(y = Female_Jail_Population_Age_15_64), color = "green") +
  geom_line(aes(y = Male_Jail_Population_Age_15_64), color = "purple") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Female vs Male Age 15-64 Jail Population", x = "Year", y = "Population")

ggplotly(comparison)

#Signifcant Values

max_female_15_64 <- cleandata2 %>%
  filter(Female_Jail_Population_Age_15_64 == max(Female_Jail_Population_Age_15_64, na.rm=TRUE)) %>%
  pull(Female_Jail_Population_Age_15_64)
  #2015

max_male_15_64 <- cleandata2 %>%
  filter(Male_Jail_Population_Age_15_64 == max(Male_Jail_Population_Age_15_64, na.rm=TRUE)) %>%
  pull(Male_Jail_Population_Age_15_64)
  #2016

################################################################

library(tidyverse)
library(dplyr)
library(maps)
library(patchwork)
library(plotly)
library(usmap)
library(ggplot2)


cleandata3 <- incarcerations_table %>%
  filter(year == 2016) %>%
  mutate(Year = year, state = state, total_jail_from_ice) %>%
  group_by(state) %>%
  summarize(Total_Jail_Population_From_Ice = sum(total_jail_from_ice)) %>%
  select(state, Total_Jail_Population_From_Ice)

Mappp <- plot_usmap(data = cleandata3, values = "Total_Jail_Population_From_Ice", color = "black") +
  scale_fill_continuous(low = "white", high = "skyblue", name = "Total Jail Population from Ice (2016)", label = scales::comma) +
  labs(title = "USA Map") + 
  theme_minimal()

ggplotly(Mappp)

#Significant Numbers

max_jail_from_ice <- cleandata3 %>%
  filter(Total_Jail_Population_From_Ice == max(Total_Jail_Population_From_Ice, na.rm = TRUE)) %>%
  pull(Total_Jail_Population_From_Ice)

