#A3 - Tom Jubin - map

library(tidyverse)
library(dplyr)
library(maps)
library(patchwork)
library(plotly)
library(usmap)
library(ggplot2)

incarcerations_table <- read_incarcerations_trends()

cleandata <- incarcerations_table %>%
  filter(year == 2016) %>%
  mutate(Year = year, state = state, total_jail_from_ice) %>%
  group_by(state) %>%
  summarize(Total_Jail_Population_From_Ice = sum(total_jail_from_ice)) %>%
  select(state, Total_Jail_Population_From_Ice)

Mappp <- plot_usmap(data = cleandata, values = "Total_Jail_Population_From_Ice", color = "black") +
  scale_fill_continuous(low = "white", high = "skyblue", name = "Total Jail Population from Ice (2016)", label = scales::comma) +
  labs(title = "USA Map") + 
  theme_minimal()

ggplotly(Mappp)

#Significant Numbers

max_jail_from_ice <- cleandata %>%
  filter(Total_Jail_Population_From_Ice == max(Total_Jail_Population_From_Ice, na.rm = TRUE)) %>%
  pull(Total_Jail_Population_From_Ice)

