library(tidyverse)
library(modelsummary)
library(mice)
library(flextable)

#1. I first ran a "git pull origin master" from my OSCER DScourseS22
#2. From github I clicked on Fetch Upstream and then I clicked Fetch and Merge
#3. I successfully installed the mice and model summary pakcages with the command install.packages("")
#4. I uploaded the wages.csv to my main directory in R
Wg <- read_csv("wages.csv")
#5. Drop observations where either hgc or tenure are missing
Wg <- Wg[complete.cases(Wg$hgc,Wg$tenure),]

head(Wg)

datasummary_skim(Wg, output = 'latex')

#The log wages seem to be missing at a pretty high rate. I believe they're missing at MAR.

Wg <- mutate(Wg, output = 'latex')
#7
Wg <- mutate(Wg, tenure_sqrd=tenure^2)

equation <- lm(logwage ~ hgc + college +tenure+tenure_sqrd +age+married,data=Wg[complete.cases(Wg$logwage),])

mean_reg = 

modelsummary(equation, output = "table.tex")

Wg_2 <- Wg
Wg_2$logwage[is.na(Wg_2$logwage)] <- mean(Wg[complete.cases(Wg_2$logwage),]$logwage)
equation_2 <- lm(logwage ~ hgc +college+tenure+tenure_sqrd+age+married,data=Wg_2)
modelsummary(equation_2, output = "tabe2.tex")

Wg_3 <- Wg
Wg_3$logwage[is.na(Wg_3$logwage)] <- predict(equation, newdata =Wg_3[is.na(Wg_3$logwage),])
equation_3 <- lm(logwage ~ hgc+college+tenure+tenure_sqrd+age+married,data=Wg_3)
modelsummary(equation_3, output = "table3.tex")

#Here we use mice

Wg_4 <- complete(mice(Wg_2, m=5, printFlag = F))
equation_4 <- lm(logwage ~ hgc +college+tenure+tenure_sqrd+age+married,data=Wg_4)
modelsummary(equation_4, output = "table4.tex")


modelsummary(list(equation,equation_2,equation_3,equation_4), output="latex", stars = TRUE)
