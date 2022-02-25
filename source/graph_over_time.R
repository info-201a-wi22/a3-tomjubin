#A3 - Tom Jubin - analysis.R file

library(ggplot2)
library(dplyr)
library(reshape2)
library(plotly)

incarcerations_table <- read_incarcerations_trends()

cleandata <- incarcerations_table %>%
  mutate(Year = year, Total_Black_Jail_Population = black_jail_pop, Total_White_Jail_Population = white_jail_pop, Total_Jail_Population = total_jail_pop) %>%
  select(Year, Total_Black_Jail_Population, Total_White_Jail_Population, Total_Jail_Population)

line_graph <- ggplot(data=cleandata, aes(x=Year))+
  geom_line(aes(y = Total_Jail_Population), color = "green") +
  geom_line(aes(y = Total_Black_Jail_Population), color = "black") +
  geom_line(aes(y = Total_White_Jail_Population), color = "blue", linetype = "twodash") 
  #labs(title = "Black v White v Total ", 
      # x = "Years", 
       #y = "Blah",
       #color = "Blah",
       #subtitle = "Blah",
       #caption = "Blah")+
  #theme_minimal()

ggplotly(line_graph)
