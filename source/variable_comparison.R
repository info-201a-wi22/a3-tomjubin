#A3 - Tom Jubin - analysis.R file

library(ggplot2)
library(dplyr)
library(reshape2)
library(plotly)
library(tidyr)

incarcerations_table <- read_incarcerations_trends()

cleandata <- incarcerations_table %>%
  mutate(Year = year, Female_Jail_Population = female_jail_pop, Male_Jail_Population = male_jail_pop) %>%
  select(Year, Female_Jail_Population, Male_Jail_Population)

boyvgirl <- ggplot(data=cleandata, aes(x=Year))+
  geom_line(aes(y = Female_Jail_Population), color = "black") +
  geom_line(aes(y = Male_Jail_Population), color = "yellow") 

ggplotly(boyvgirl)
