#A3 - Tom Jubin - analysis.R file

library(tidyverse)
library(dplyr)
library(maps)
library(mapproj)
library(patchwork)
library(plotly)
library(usmap)
library(ggplot2)

incarcerations_table <- read_incarcerations_trends()

cleandata <- incarcerations_table %>%
  filter(year == 2018) %>%
  mutate(Year = year, state = state, total_jail_from_ice) %>%
  group_by(state) %>%
  summarize(Total_Jail_Population_From_Ice = sum(total_jail_from_ice)) %>%
  select(state, Total_Jail_Population_From_Ice)



Mapp <- plot_usmap(data = cleandata, values = "Total_Jail_Population_From_Ice", color = "red") + 
  labs(title = "US",
       subtitle = "This is a blank map of the counties of the United States.") + 
  theme_minimal()

ggplotly(Mapp)
