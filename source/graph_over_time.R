#A3 - Tom Jubin - graph over time

library(ggplot2)
library(dplyr)
library(reshape2)
library(plotly)

incarcerations_table <- read_incarcerations_trends()

cleandata <- incarcerations_table %>%
  mutate(Year = year, Total_Black_Jail_Population = black_jail_pop, Total_White_Jail_Population = white_jail_pop, Total_Jail_Population = total_jail_pop) %>%
  select(Year, Total_Black_Jail_Population, Total_White_Jail_Population, Total_Jail_Population)

time_graph <- ggplot(data=cleandata, aes(x=Year))+
  geom_line(aes(y = Total_Jail_Population), color = "yellow") +
  geom_line(aes(y = Total_Black_Jail_Population), color = "black") +
  geom_line(aes(y = Total_White_Jail_Population), color = "white") + 
  labs(title = "Total vs Black vs White Jail Population ", 
       x = "Year", 
       y = "Population")

ggplotly(time_graph)

#Signficant Values

max_black_jail_pop <- cleandata %>%
  filter(Total_Black_Jail_Population == max(Total_Black_Jail_Population, na.rm=TRUE)) %>%
  pull(Total_Black_Jail_Population)
 
max_white_jail_pop_during_max_black_jail_pop <- cleandata %>%
  filter(Year == 1993) %>%
  filter(Total_White_Jail_Population == max(Total_White_Jail_Population, na.rm=TRUE)) %>%
  pull(Total_White_Jail_Population) 

total_jail_pop_during_max_black_jail_pop <- cleandata %>%
  filter(Year == 1993) %>%
  filter(Total_Jail_Population == max(Total_Jail_Population, na.rm = TRUE)) %>%
  pull(Total_Jail_Population)
