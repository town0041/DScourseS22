library(tidyverse)
library(sparklyr)
library(dplyr)
#6.1: libraries of tidyverse and sparklyr
#6.2: I installed both sparklyr and tidyverse
#6.3: I loaded sparklyr and tidyverse
#6.4
spark_install(version = "3.0.0")
sc <- spark_connect(master = "local")
#6.5
df1 <- iris %>% as_tibble()
#6.6
df <- copy_to(sc, df1)
#6.7
class(df1)
#df1 is a tbl_spark class
class(df)
#df is a tbl_df class
#6.8
df %>% colnames()
df1 %>% colnames()
#They are different with df having "Sepal_Length" and df1 having "Sepal.Length" They are marginally different because they differ in class.
#6.9
df %>% select(Sepal_Length,Species) %>% head %>% print
#6.10
df %>% filter(Sepal_Length>5.5) %>%head %>% print
#6.11
df %>% select(Sepal_Length,Species) %>% filter(Sepal_Length>5.5) %>% head %>% print 
df2 <- df %>% group_by(Species) %>% summarize(mean = mean(Sepal_Length), count = n()) %>% head %>% print
#6.13
df2 %>% arrange(Species) %>% head %>% print
