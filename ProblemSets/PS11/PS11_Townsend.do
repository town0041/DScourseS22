clear

import delimited "C:\Users\wat20\OneDrive\Documents\DS_RoughDraftData.csv", stringcols(4) 

sort state year

encode year, gen(Year)
encode state, gen(State)
tsset State Year

eststo: reg log_homicide border cartel export_ratio, robust

eststo: reg log_homicide border cartel export_ratio i.Year, robust

eststo: reg log_homicide border cartel export_ratio i.State, robust

eststo: reg log_homicide border cartel export_ratio i.Year i.State, robust

esttab using table1.csv, replace se r2

eststo clear
