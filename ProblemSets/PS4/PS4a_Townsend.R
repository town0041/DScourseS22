#5.a-c
library(tidyverse)
library(jsonlite)
system('wget -O dates.json "https://www.vizgr.org/historical-events/search.php?format=json&begin_date=00000101&end_date=20220219&lang=en"')
mylist <- fromJSON("dates.json")
mydf <- bind_rows(mylist$result[-1])
class(mydf)
#5.d
mydf$date %>% class()
#5.e
mydf %>% head()
