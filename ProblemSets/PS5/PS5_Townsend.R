library(rvest)
library(tidyverse)
library(dplyr)
library(pdfetch)

#Problem 3
#I looked up a wikipedia page displaying notable people that the US has deported.

h <- read_html("https://en.wikipedia.org/wiki/List_of_people_deported_or_removed_from_the_United_States")

reps <- h %>%
  html_node("#mw-content-text > div.mw-parser-output > table") %>% html_table()

head(reps)

#Problem 4

pdfetch_YAHOO(c("^gspc","^ixic"))
pdfetch_YAHOO(c("^gspc","^ixic"), "adjclose")

