
library(rvest)
library(tidyverse)

#For this assignment I scraped data from this wikipedia page on homicide rates in Mexico's states.

url <- "https://en.wikipedia.org/wiki/List_of_Mexican_states_by_homicides"

# Read the HTML code from the website
webpage <- read_html(url)

# Use CSS selectors to scrape the table
table <- html_nodes(webpage,'table.wikitable.sortable')

# Converting the table to a data frame
table <- html_table(table, header = TRUE)

#Next I adjust columns in my data to have appropriate names

Mexico_Homicide <- table %>%
  bind_rows() %>%
  as_tibble() %>% select(-Sources) %>% gather(key = "Years", value = "Homicide", -1) 

#Next, I cleared out observations that had blank values for my state and homicide columns

names(Mexico_Homicide)[1]="State" 
Mexico_Homicide$State %>% unique() 
Mexico_Homicide=Mexico_Homicide[Mexico_Homicide$State!="",]

#My following step included making my variables register as numeric values.

Mexico_Homicide %>% summary()
Mexico_Homicide$Homicide=Mexico_Homicide$Homicide %>% as.numeric()
Mexico_Homicide$Years=Mexico_Homicide$Years %>% as.numeric()

#Below I create my three plots. 

ggplot(Mexico_Homicide, aes(x=Years, y=Homicide))+geom_point()+geom_smooth(method = "lm")+theme_bw()
ggplot(Mexico_Homicide)+geom_histogram(aes(Homicide))+theme_classic()
Mexico_Homicide$LogHomicide=log(Mexico_Homicide$Homicide+1)
ggplot(Mexico_Homicide)+geom_histogram(aes(LogHomicide))+theme_classic()
