library(jsonlite)
library(tidyverse)
library(janitor)
library(dplyr)
library(ggplot2)
library(googlesheets4)
library(stringr)
library(rvest)
library(XML)
library(RCurl)
library(rjson)
library(png)

date <- Sys.Date()


womens_url <- getURL("https://ouastats.prestosports.com/sports/wice/2021-22/players?sort=p&view=&pos=sk&r=0")
womens_table <- readHTMLTable(womens_url)
OUA_WHKY_Stats <- as.data.frame(womens_table$"NULL")
OUA_WHKY_Stats = OUA_WHKY_Stats[-1,]

OUA_WHKY_Stats <- OUA_WHKY_Stats %>% 
  select(Name, `&nbsp`, gp, g, a, pts, pim) %>% 
  rename(School = `&nbsp`)

OUA_WHKY_Stats$gp <- as.numeric(OUA_WHKY_Stats$gp)
OUA_WHKY_Stats$pts <- as.numeric(OUA_WHKY_Stats$pts)

OUA_WHKY_Stats <- OUA_WHKY_Stats %>% 
  mutate(`pts/g` = pts / gp)

Nipissing_WHKY <- OUA_WHKY_Stats %>% 
  filter(School == "Nipissing")
Nipissing_WHKY$Round_off <- round(Nipissing_WHKY$`pts/g` ,digit=2)

